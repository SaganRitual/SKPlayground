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

        entity.halo?.deselect()
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()
    }

    func deselectAll() {
        entities.forEach { deselect($0) }
    }

    func getSelected() -> Set<GameEntity> {
        getSelected(self.entities)
    }

    func getSelected(_ entities: Set<GameEntity>) -> Set<GameEntity> {
        let selected = entities.compactMap { entity in
            entity.halo!.isSelected ? entity : nil
        }

        return Set(selected)
    }

    func select(_ entity: GameEntity) {
        entity.halo?.select()
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()
    }

    func toggleSelect(_ entity: GameEntity) {
        cancelAssignActionsMode()

        entity.halo?.toggleSelect()
        entitySelectionState.setSelectionState(getSelected())
        reloadEntityViews()
    }
}
