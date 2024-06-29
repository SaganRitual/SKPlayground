// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

extension GameController {

    func drag(_ dragDispatch: DragDispatch) {
        switch dragDispatch.phase {
        case .begin:
            let entity = dragDispatch.entity!

            if !entity.isSelected {
                entity.select()
            }

            setDragAnchorsForSelected()

        case .continue:
            moveSelected(dragDispatch)

        case .end:
            break
        }
    }

    func moveSelected(_ dragDispatch: DragDispatch) {
        let delta = dragDispatch.location - dragDispatch.entity!.dragAnchor!

        getSelected().forEach { entity in
            entity.position = entity.dragAnchor! + delta
        }
    }

    func roscaleSelected(_ dragDispatch: DragDispatch) {
        let endVertex = dragDispatch.location
        let dragAnchor = dragDispatch.entity!.dragAnchor!

        let delta = endVertex - dragAnchor
        let distance = delta.magnitude
        let scale = max(1, distance / SelectionHaloRS.radius)
        var rotation = atan2(delta.y, delta.x)

        switch dragDispatch.subhandleDirection! {
        case .n: rotation -= .pi / 2
        case .e: rotation += 0
        case .s: rotation += .pi / 2
        case .w: rotation += .pi
        }

        let rDelta = rotation - dragDispatch.entity!.rotationAnchor!
        let sDelta = scale - dragDispatch.entity!.scaleAnchor!

        getSelected().forEach { entity in
            entity.rotation = entity.rotationAnchor! + rDelta
            entity.scale = entity.scaleAnchor! + sDelta
        }
    }

    func setDragAnchorsForSelected() {
        getSelected().forEach { entity in
            entity.dragAnchor = entity.position
        }
    }

    func setRoscaleAnchorsForSelected() {
        getSelected().forEach { entity in
            entity.rotationAnchor = entity.rotation
            entity.scaleAnchor = entity.scale
        }
    }

    func subhandleDrag(_ dragDispatch: DragDispatch) {
        switch dragDispatch.phase {
        case .begin:
            let entity = dragDispatch.entity!

            entity.dragAnchor = entity.position
            setRoscaleAnchorsForSelected()

        case .continue:
            roscaleSelected(dragDispatch)

        case .end:
            break
        }

    }

}
