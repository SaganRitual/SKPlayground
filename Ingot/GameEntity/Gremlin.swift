// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class Gremlin: GameEntity {
    private let halo_: SelectionHalo
    override var halo: SelectionHalo? { halo_ }

    private let avatar_: GameEntitySprite
    override var avatar: GameEntitySprite? { avatar_ }

    var actionTokens = [any ActionTokenProtocol]()

    var anchorMoveAction: CGPoint?
    var anchorRotateAction: CGFloat?
    var anchorScaleAction: CGFloat?

    var viewSpriteNode: SKSpriteNode {
        avatar!.sceneNode as! SKSpriteNode
    }

    override var physicsBody: SKPhysicsBody? {
        get { avatar?.sceneNode.physicsBody }
        set { avatar?.sceneNode.physicsBody = newValue }
    }

    override var rotation: CGFloat {
        get { avatar?.sceneNode.zRotation ?? 0 }
        set {
            avatar?.sceneNode.zRotation = newValue
            halo?.sceneNode.zRotation = newValue
        }
    }

    override var scale: CGFloat {
        get {
            guard let sn = avatar?.sceneNode else { return 0 }
            return sn.xScale
        }

        set {
            avatar?.sceneNode.setScale(newValue)
            halo?.setScale(newValue)
        }
    }

    init(halo halo_: SelectionHalo, view avatar_: GameEntitySprite) {
        self.halo_ = halo_
        self.avatar_ = avatar_
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
            halo!.sceneNode.run(group)
            avatar!.sceneNode.run(group)
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

    static func make(at position: CGPoint, avatarName: String) -> Gremlin {
        let halo = SelectionHaloRS.make()
        let view = GremlinSprite(avatarName)
        let gremlin = Gremlin(halo: halo, view: view)

        halo.sceneNode.setOwnerEntity(gremlin)
        view.sceneNode.setOwnerEntity(gremlin)

        halo.subhandles.values.forEach { sh in
            sh.sceneNode.setOwnerEntity(gremlin)
        }

        gremlin.position = position

        return gremlin
    }
}
