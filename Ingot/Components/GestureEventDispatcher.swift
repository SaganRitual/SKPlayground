// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GestureEventDispatcher: InputEventDispatcher.GestureDelegate {
    weak var contextMenuManager: ContextMenuManager!
    weak var gameController: GameController!
    weak var selectionMarquee: SelectionMarquee!
    weak var workflowManager: WorkflowManager!

    enum DragMode { case background, idle, entity, subhandle }
    var dragMode = DragMode.idle

    func gestureEvent(_ gestureEvent: GestureEvent) {
        switch gestureEvent.newGestureState {
        case .click:      click(gestureEvent)
        case .drag:       dragDispatch(gestureEvent)
        case .dragEnd:    dragEnd(gestureEvent)
        case .rightClick: rightClick(gestureEvent)

        case .idle:     // This is mouse move; we don't care about it at this high level
            break

        case .limbo:    // This is right or left mouse button down, awaiting drag or mouse up
            break
        }
    }
}

private extension GestureEventDispatcher {

    func click(_ gestureEvent: GestureEvent) {
        switch workflowManager.workflowRelay.currentWorkflow {
        case .assigningSpaceActions:
            fatalError("You thought this couldn't happen")

        case .idle:
            clickWorkflowIdle(gestureEvent)

        case .placingEdgeVertices:
            clickWorkflowPlacingEdgeVertices(gestureEvent)

        case .placingPhysicsJoint:
            break

        case .placingRegionVertices:
            break

        case .placingWaypoints:
            break
        }
    }

    func clickWorkflowIdle(_ gestureEvent: GestureEvent) {
        var entity = gestureEvent.inputEvent.getTopEntity()

        if gestureEvent.inputEvent.shift {
            // Shift-click
            if let entity {
                // On an existing entity
                gameController.toggleSelect(entity)
                return
            }
        } else {
            // Click with no shift, either on background or on an existing entity
            gameController.deselectAll()
        }

        if entity == nil {
            // User clicked the background; create new entity here
            entity = gameController.newEntity(at: gestureEvent.inputEvent.location)
        }

        // New entity, or newly selected entity
        gameController.select(Utility.forceUnwrap(entity))
    }

    func clickWorkflowPlacingEdgeVertices(_ gestureEvent: GestureEvent) {
        var entity = gestureEvent.inputEvent.getTopEntity()

        if gestureEvent.inputEvent.shift {
            // Shift-click
            if let entity {
                // On an existing entity
                gameController.toggleSelect(entity)
                return
            }
        } else {
            // Click with no shift, either on background or on an existing entity
            gameController.deselectAll()
        }

        if entity == nil {
            // User clicked the background; create new entity here
            entity = gameController.newEntity(at: gestureEvent.inputEvent.location)
        }

        // New entity, or newly selected entity
        gameController.select(Utility.forceUnwrap(entity))
    }

    func rightClick(_ gestureEvent: GestureEvent) {
        gameController.deselectAll()

        let entity = gestureEvent.inputEvent.getTopEntity()
        if let gremlin = entity as? Gremlin {
            gameController.select(gremlin)
            contextMenuManager.showMenu(.entity, gestureEvent)
        } else if entity == nil {
            contextMenuManager.showMenu(.scene, gestureEvent)
        }
    }

}

private extension GestureEventDispatcher {

    func dragBegin(_ gestureEvent: GestureEvent) {
        // We're beginning a drag operation
        if let entity = gestureEvent.inputEvent.getTopEntity() {
            if let haloRS = entity.face.halo as? SelectionHaloRS {
                let topNode = Utility.forceUnwrap(gestureEvent.inputEvent.getTopNode())
                if let direction = haloRS.getSubhandleDirection(topNode) {
                    // Dragging a subhandle on a Gremlin's halo
                    let entity = Utility.forceUnwrap(topNode.getOwnerEntity())
                    gameController.setDragAnchors(entity, direction)
                    dragMode = .subhandle
                    return
                }
            }

            // Dragging on an entity or its main halo, not a subhandle;
            // select the entity if necessary, deselect others if necessary
            if !entity.isSelected {
                if !gestureEvent.inputEvent.shift {
                    gameController.deselectAll()
                }

                gameController.select(entity)
            }

            // Dragging selected entities using this one as an anchor
            gameController.setDragAnchors(entity)
            dragMode = .entity
        } else {
            // Dragging on the background, ie, beginning a marquee selection
            selectionMarquee.setDragAnchor(gestureEvent.inputEvent.location)
            dragMode = .background
        }
    }

    func dragContinue(_ gestureEvent: GestureEvent) {
        // We're continuing a drag operation
        switch dragMode {
        case .background:
            selectionMarquee.draw(to: gestureEvent.inputEvent.location)
        case .entity:
            gameController.moveSelected(gestureEvent.inputEvent.location)
        case .subhandle:
            gameController.roscaleSelected(gestureEvent.inputEvent.location)
        default:
            fatalError("We thought this couldn't happen")
        }
    }

    func dragDispatch(_ gestureEvent: GestureEvent) {
        if gestureEvent.oldGestureState == .limbo {
            dragBegin(gestureEvent)
        } else if gestureEvent.oldGestureState == .drag {
            dragContinue(gestureEvent)
        }
    }

    func dragEnd(_ gestureEvent: GestureEvent) {
        if gestureEvent.inputEvent.getTopEntity() == nil {
            // Drag-end only matters when dragging the background, so we know when the user is done dragging out
            // the rectangle. For entities, we just aren't dragging any more, so there's nothing to do

            let rectangle = selectionMarquee.getRectangle(endVertex: gestureEvent.inputEvent.location)
            let enclosedNodes = gestureEvent.inputEvent.scene.getNodesInRectangle(rectangle)
            let enclosedEntities = Set(enclosedNodes.compactMap { $0.getOwnerEntity() })
            gameController.commitMarqueeSelect(enclosedEntities, gestureEvent.inputEvent.shift)
        }

        selectionMarquee.hide()
        dragMode = .idle
    }

}
