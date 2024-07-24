// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

extension GameController {
    func commitMarqueeSelect(_ entities: Set<GameEntity>, _ shiftKey: Bool) {
        if shiftKey {
            entities.forEach { toggleSelect($0) }
        } else {
            deselectAll()
            entities.forEach { select($0) }
        }
    }

    func deselect(_ entity: GameEntity) {
        entity.deselect()
        updateRelaysForSelection()
    }

    func deselectAll() {
        getSelected().forEach { deselect($0) }
    }

    func getSelected() -> Set<GameEntity> {
        Set(entities.compactMap({ $0.isSelected ? $0 : nil }))
    }

    func select(_ entity: GameEntity) {
        entity.select()
        updateRelaysForSelection()
    }

    func selectAction(_ token: ActionToken) {
        let gremlin = Utility.forceCast(singleSelected(), to: Gremlin.self)
        gremlin.selectedAction = token
        self.selectedAction = token
        updateRelaysForSelection()
    }

    func toggleSelect(_ entity: GameEntity) {
        if entity.isSelected {
            deselect(entity)
        } else {
            select(entity)
        }
    }
}
