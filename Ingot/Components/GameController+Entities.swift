// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation

extension GameController {
    func addActionToSelected(_ action: ActionToken) {
        let gremlin = Utility.forceCast(getSelected().first, to: Gremlin.self)
        gremlin.addActionToken(action)
        activateActionsRelay(for: gremlin)
    }

    func moveSelected(_ anchorTarget: CGPoint) {
        let hotAnchor = Utility.forceUnwrap(hotDragTarget?.dragAnchor)
        let delta = anchorTarget - hotAnchor

        getSelected().forEach { entity in
            let anchor = Utility.forceUnwrap(entity.dragAnchor)
            entity.position = anchor + delta
        }
    }

    func roscaleSelected(_ mousePosition: CGPoint) {
        let hotAnchor = Utility.forceUnwrap(hotDragTarget?.dragAnchor)

        let delta = mousePosition - hotAnchor
        let distance = delta.magnitude
        let scale = max(1, distance / SelectionHaloRS.radius)
        var rotation = atan2(delta.y, delta.x)

        let subhandle = Utility.forceUnwrap(hotDragSubhandle)

        switch subhandle {
        case .n: rotation -= .pi / 2
        case .e: rotation += 0
        case .s: rotation += .pi / 2
        case .w: rotation += .pi
        }

        let rDelta = rotation - Utility.forceUnwrap(hotDragTarget?.rotationAnchor)
        let sDelta = scale - Utility.forceUnwrap(hotDragTarget?.scaleAnchor)

        getSelected().forEach { entity in
            entity.rotation = entity.rotationAnchor! + rDelta
            entity.scale = entity.scaleAnchor! + sDelta
        }
    }

    func setDragAnchors(_ anchorEntity: GameEntity, _ subhandleDirection: SelectionHaloRS.Directions? = nil) {
        hotDragTarget = anchorEntity
        hotDragSubhandle = subhandleDirection

        getSelected().forEach { entity in
            entity.dragAnchor = entity.position
            entity.rotationAnchor = entity.rotation
            entity.scaleAnchor = entity.scale
        }
    }
}

extension GameController {
    func newEntity(at position: CGPoint) -> GameEntity {
        switch workflowRelay.clickToPlace {
        case .field:
            return placeField(at: position)
        case .gremlin:
            return placeGremlin(at: position)
        case .joint:
            return placeJoint(at: position)
        case .vertex:
            return placeVertex(at: position)
        }
    }

    func placeField(at position: CGPoint) -> SKPPhysicsField {
        let field = SKPPhysicsField.make(at: position, fieldType: workflowRelay.fieldType)
        postPlace(field)
        return field
    }

    func placeGremlin(at position: CGPoint) -> Gremlin {
        let gremlin = Gremlin.make(at: position, avatarName: workflowRelay.avatarName)
        postPlace(gremlin)
        return gremlin
    }

    func placeJoint(at position: CGPoint) -> SKPPhysicsJoint {
        let joint = SKPPhysicsJoint.make(at: position, type: workflowRelay.jointType)
        postPlace(joint)
        return joint
    }

    func placeVertex(at position: CGPoint) -> Vertex {
        let vertex = Vertex.make(at: position)
        postPlace(vertex)
        return vertex
    }

    private func postPlace(_ entity: GameEntity) {
        entities.insert(entity)
        sceneManager.addEntity(entity)
        selectPhysicsEntity(entity)
    }

    func selectPhysicsEntity(_ entity: GameEntity) {
        if entity is Gremlin {
            selectedPhysicsBody = entity.physicsBody
            selectedPhysicsField = nil
            selectedPhysicsJoint = nil
            return
        }

        if let field = entity as? SKPPhysicsField {
            selectedPhysicsBody = nil
            selectedPhysicsField = field
            selectedPhysicsJoint = nil
            return
        }

        if let joint = entity as? SKPPhysicsJoint {
            selectedPhysicsBody = nil
            selectedPhysicsField = nil
            selectedPhysicsJoint = joint
            return
        }
    }
}
