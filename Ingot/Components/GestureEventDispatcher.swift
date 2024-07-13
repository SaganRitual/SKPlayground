// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GestureEventDispatcher: InputEventDispatcher.GestureDelegate {
    weak var contextMenuManager: ContextMenuManager!
    weak var entityManager: EntityManager!
    weak var selectionMarquee: SelectionMarquee!

    var draggingEntity = false

    func gestureEvent(_ gestureEvent: GestureEvent) {
        switch gestureEvent.newGestureState {
        case .click:      click(gestureEvent)
        case .drag:       drag(gestureEvent)
        case .dragEnd:    dragEnd(gestureEvent)
        case .rightClick: rightClick(gestureEvent)

        case .limbo:
            break

        default:
            fatalError("You said this couldn't happen")
        }
    }
}

private extension GestureEventDispatcher {

    func click(_ gestureEvent: GestureEvent) {
        var entity = gestureEvent.inputEvent.getTopEntity()

        if gestureEvent.inputEvent.shift {
            // Shift-click
            if let entity {
                // On an existing entity
                entityManager.toggleSelect(entity)
                return
            }
        } else {
            // Click with no shift, either on background or on an existing entity
            entityManager.deselectAll()
        }

        // If we didn't just click an entity, create one here
        if entity == nil {
            entity = entityManager.newEntity(at: gestureEvent.inputEvent.location)
        }

        // New entity, or newly selected entity
        entityManager.select(Utility.forceUnwrap(entity))
    }

    func drag(_ gestureEvent: GestureEvent) {
        if gestureEvent.oldGestureState == .limbo {
            // We're beginning a drag operation
            if let entity = gestureEvent.inputEvent.getTopEntity() {
                // Dragging on an entity; select if necessary, deselect others if necessary
                if !entity.isSelected {
                    if !gestureEvent.inputEvent.shift {
                        entityManager.deselectAll()
                    }

                    entityManager.select(entity)
                }

                // Dragging selected entities using this one as an anchor
                entityManager.setDragAnchors(entity)

                draggingEntity = true
            } else {
                // Dragging on the background, ie, beginning a marquee selection
                selectionMarquee.setDragAnchor(gestureEvent.inputEvent.location)
                draggingEntity = false
            }
        } else if gestureEvent.oldGestureState == .drag {
            // We're continuing a drag operation
            if draggingEntity {
                // Dragging selected entities
                entityManager.moveSelected(gestureEvent.inputEvent.location)
            } else {
                // Dragging out a rubber-band selection rectangle
                selectionMarquee.draw(to: gestureEvent.inputEvent.location)
            }
        }
    }

    func dragEnd(_ gestureEvent: GestureEvent) {
        if gestureEvent.inputEvent.getTopEntity() == nil {
            // Drag-end only matters when dragging the background, so we know when the user is done dragging out
            // the rectangle. For entities, we just aren't dragging any more, so there's nothing to do

            let rectangle = selectionMarquee.getRectangle(endVertex: gestureEvent.inputEvent.location)
            let enclosedNodes = gestureEvent.inputEvent.scene.getNodesInRectangle(rectangle)
            let enclosedEntities = Set(enclosedNodes.compactMap { $0.getOwnerEntity() })
            entityManager.commitMarqueeSelect(enclosedEntities, gestureEvent.inputEvent.shift)
        }

        selectionMarquee.hide()
        draggingEntity = false
    }

    func rightClick(_ gestureEvent: GestureEvent) {
        contextMenuManager.showMenu(gestureEvent.inputEvent.getTopEntity() == nil ? .scene : .entity, gestureEvent)
    }

}
