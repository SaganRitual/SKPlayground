// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class Gremlin: GameEntity {
    var anchorMoveAction: CGPoint?
    var anchorRotateAction: CGFloat?
    var anchorScaleAction: CGFloat?

    var actions = [ActionToken]()
    var fields = [SKPPhysicsField]()
    var joints = [SKPPhysicsJoint]()

    private var physicsBody_: SKPPhysicsBody

    override var physicsBody: SKPPhysicsBody? {
        get { physicsBody_ }
        set { physicsBody_ = Utility.forceUnwrap(newValue) }
    }

    override var rotation: CGFloat {
        get { face.rotation }
        set { face.rotation = newValue }
    }

    override var scale: CGFloat {
        get { face.scale }
        set { face.scale = max(1, newValue) }
    }

    init(at position: CGPoint, avatarName: String) {
        self.physicsBody_ = SKPPhysicsBody(SKPhysicsBody(circleOfRadius: 15))

        let face = GremlinFace(at: position, avatarName: avatarName)
        super.init(face)
    }

    static func make(at position: CGPoint, avatarName: String) -> Gremlin {
        let gremlin = Gremlin(at: position, avatarName: avatarName)

        gremlin.face.rootSceneNode.physicsBody = Utility.forceUnwrap(gremlin.physicsBody).body
        gremlin.face.setOwnerEntity(gremlin)

        return gremlin
    }

    override func addActionToken(_ token: ActionToken) {
        actions.append(token)
        selectedAction = token
    }

    override func cancelActionsMode() {
        resetSelectionMode()
        restoreActionAnchors()
    }

    override func commitFollowPathAction(_ token: ActionToken) {
        addActionToken(token)
    }

    override func commitPhysicsAction(_ token: ActionToken) {
        addActionToken(token)
    }

    override func commitSpaceActions(duration: TimeInterval) {
        resetSelectionMode()

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
    }
}
