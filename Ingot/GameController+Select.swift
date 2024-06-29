// We are a way for the cosmos to know itself. -- C. Sagan

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

        if entitySelectionState.selectionState == .one {
            loadPhysicsBodyFromSelected()
        }
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
        entity.select()
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()

        if entitySelectionState.selectionState == .one {
            loadPhysicsBodyFromSelected()
        }
    }

    func toggleSelect(_ entity: GameEntity) {
        cancelAssignActionsMode()

        entity.toggleSelect()
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()

        if entitySelectionState.selectionState == .one {
            loadPhysicsBodyFromSelected()
        }
    }
}
