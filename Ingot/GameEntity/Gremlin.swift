// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class Gremlin: GameEntity {
    var actionTokens = [any ActionTokenProtocol]()

    var anchorMoveAction: CGPoint?
    var anchorRotateAction: CGFloat?
    var anchorScaleAction: CGFloat?

    override var physicsBody: SKPhysicsBody? {
        // For most operations we talk to the face, but the physics
        // engine really does require the physics body to be attached
        // to the avatar sprite
        get { face.avatar!.sceneNode.physicsBody }
        set { face.avatar!.sceneNode.physicsBody = newValue }
    }

    override var rotation: CGFloat {
        get { face.rotation }
        set { face.rotation = newValue }
    }

    override var scale: CGFloat {
        get { face.scale }
        set { face.scale = newValue }
    }

    init(at position: CGPoint, avatarName: String) {
        let face = GremlinFace(at: position, avatarName: avatarName)
        super.init(face)
    }

    static func make(at position: CGPoint, avatarName: String) -> Gremlin {
        let gremlin = Gremlin(at: position, avatarName: avatarName)

        gremlin.face.setOwnerEntity(gremlin)

        return gremlin
    }

    override func addActionToken(_ token: any ActionTokenProtocol) {
        actionTokens.append(token)
    }

    override func cancelActionsMode() {
        setAssignActionsMode(false)
        restoreActionAnchors()
    }

    override func commitPhysicsAction(_ token: ActionTokenProtocol) {
        addActionToken(token)
    }

    override func commitSpaceActions(duration: TimeInterval) {
        setAssignActionsMode(false)

        if let dragAnchor = dragAnchor, dragAnchor != position {
            let t = MoveActionToken(duration: duration, targetPosition: position)
            addActionToken(t)
        }

        if let rotationAnchor = rotationAnchor, rotationAnchor != rotation {
            let t = RotateActionToken(duration: duration, targetRotation: rotation)
            addActionToken(t)
        }

        if let scaleAnchor = scaleAnchor, scaleAnchor != scale {
            let t = ScaleActionToken(duration: duration, targetScale: scale)
            addActionToken(t)
        }

        restoreActionAnchors()
     }

    override func getActionTokens() -> [ActionTokenContainer] {
        actionTokens.map { ActionTokenContainer(token: $0) }
    }

    override func restoreActionAnchors() {
        var actions = [SKAction]()

        if let move = anchorMoveAction{
            let a = SKAction.move(to: move, duration: 0.5)
            actions.append(a)

            anchorMoveAction = nil
        }

        if let rotate = anchorRotateAction {
            let a = SKAction.rotate(toAngle: rotate, duration: 0.5)
            actions.append(a)

            anchorRotateAction = nil
        }

        if let scale = anchorScaleAction {
            let a = SKAction.scale(to: scale, duration: 0.5)
            actions.append(a)

            anchorScaleAction = nil
        }

        if !actions.isEmpty {
            let group = SKAction.group(actions)
            face.rootSceneNode.run(group)
        }
    }

    override func startActionsMode() {
        if actionTokens.isEmpty {
            anchorMoveAction = position
            anchorRotateAction = rotation
            anchorScaleAction = scale
        } else {
            if let lastMove = actionTokens.last(where: { $0 is MoveActionToken }) as? MoveActionToken {
                position = lastMove.targetPosition
            }

            if let lastRotate = actionTokens.last(where: { $0 is RotateActionToken }) as? RotateActionToken {
                rotation = lastRotate.targetRotation
            }

            if let lastScale = actionTokens.last(where: { $0 is ScaleActionToken }) as? ScaleActionToken {
                scale = lastScale.targetScale
            }
        }

        setAssignActionsMode(true)
    }
}
