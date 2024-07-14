// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class JointSprite: GameEntitySprite {
    init() {
        let image = Image(systemName: "link.circle.fill").font(.title)

        // Thanks Oskar!
        // https://stackoverflow.com/a/69315037/1610473
        let renderedByOskar = image.renderAsImage()!

        let texture = SKTexture(image: renderedByOskar)
        let sprite = SKSpriteNode(texture: texture)

        sprite.color = .yellow
        sprite.colorBlendFactor = 1

        super.init(sceneNode: sprite)
    }
}

final class Joint: GameEntity {
    let physicsJoint: SKPhysicsJoint

    static func make(at position: CGPoint, type: PhysicsJointType) -> Joint {
        let joint = Joint(at: position, type: type)
        joint.face.setOwnerEntity(joint)
        return joint
    }

    init(at position: CGPoint, type: PhysicsJointType) {
        switch type {
        case .fixed:
            self.physicsJoint = SKPhysicsJointFixed()
        case .limit:
            self.physicsJoint = SKPhysicsJointLimit()
        case .pin:
            self.physicsJoint = SKPhysicsJointPin()
        case .sliding:
            self.physicsJoint = SKPhysicsJointSliding()
        case .spring:
            self.physicsJoint = SKPhysicsJointSpring()
        }

        let halo = SelectionHalo()
        let avatar = JointSprite()
        let face = GameEntityFace(at: position, avatar: avatar, halo: halo)
        super.init(face)
    }
}
