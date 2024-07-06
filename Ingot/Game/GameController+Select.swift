// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit
import Foundation

extension GameController {

    func commitMarqueeSelect(_ entities: Set<GameEntity>, _ dragDispatch: DragDispatch) {
        if dragDispatch.shift {
            entities.forEach { toggleSelect($0) }
        } else {
            deselectAll()
            entities.forEach { select($0) }
        }
    }

    func deselect(_ entity: GameEntity) {
        cancelAssignActionsMode()

        entity.deselect()
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()
        updateOrderIndicators()
    }

    func deselectAll() {
        entities.forEach { deselect($0) }
    }

    func getSelected() -> Set<GameEntity> {
        getSelected(self.entities)
    }

    func getSelected(_ entities: Set<GameEntity>) -> Set<GameEntity> {
        let selected = entities.compactMap { entity in
            entity.isSelected ? entity : nil
        }

        return Set(selected)
    }

    func select(_ entity: GameEntity) {
        entity.select(selectionOrderTracker)
        selectionOrderTracker += 1
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()
        updateOrderIndicators()
    }

    func selectionIsUniform() -> Set<GameEntity>? {
        let selected = getSelected()
        if selected.isEmpty { return nil }

        let firstType = type(of: selected.first!)
        if selected.first(where: { type(of: $0) != firstType  }) != nil {
            return nil
        }

        return selected
    }

    func singleSelectedItemIs<T: AnyObject>(_ class: T) -> T? {
        guard entitySelectionState.selectionState == .one else { return nil }
        return getSelected().first as? T
    }

    func toggleSelect(_ entity: GameEntity) {
        cancelAssignActionsMode()

        entity.toggleSelect(selectionOrderTracker)
        selectionOrderTracker += 1
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()
        updateOrderIndicators()
    }

    func updateOrderIndicators() {
        spriteManager.releaseAll()
        entities.filter({ $0 is Vertex }).forEach { $0.resetSelectionMode() }

        guard let selected_ = selectionIsUniform(),
                  selected_.first is Vertex,
                  selected_.count > 1 else { return }

        let selected = Array(Utility.forceCast(selected_, to: Set<Vertex>.self))
                        .sorted { $0.selectionOrder < $1.selectionOrder }

        selected.first!.setOrderIndicator(.first)
        selected.last!.setOrderIndicator(.last)

        selected.dropFirst().dropLast().forEach { $0.setOrderIndicator(.inner) }

        for pair in zip(0..<(selected.count - 1), 1..<selected.count) {
            let startIx = pair.0
            let stopIx = pair.1
            let startVertex = selected[startIx]
            let stopVertex = selected[stopIx]

            drawPathSegment(from: startVertex, to: stopVertex)
        }

        if selected.count > 2 {
            drawPathSegment(from: selected.last!, to: selected.first!, color: .yellow)
        }
    }

    func drawPathSegment(from start: Vertex, to stop: Vertex, color: NSColor = .blue) {
        let line = spriteManager.getLineSprite()

        line.anchorPoint = CGPoint(x: 0, y: 0.5)
        line.color = color
        line.colorBlendFactor = 1
        line.isHidden = false
        line.position = .zero

        let fromZero = stop.position - start.position
        line.xScale = fromZero.magnitude
        line.yScale = 1
        line.zRotation = atan2(fromZero.y, fromZero.x)

        start.face.avatar?.sceneNode.addChild(line)
    }
}
