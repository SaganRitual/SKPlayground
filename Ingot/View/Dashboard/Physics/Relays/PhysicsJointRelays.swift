// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsJointRelay: ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJoint.self)
        reactionForce = joint.reactionForce
        reactionTorque = joint.reactionTorque
    }
}

final class PhysicsJointFixedRelay: PhysicsJointRelay {
}

final class PhysicsJointLimitRelay: PhysicsJointRelay {
    @Published var maxLength = CGFloat.zero

    override func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJointLimit.self)
        maxLength = joint.maxLength

        super.loadState(from: entity_)
    }
}

final class PhysicsJointPinRelay: PhysicsJointRelay {
    @Published var frictionTorque = CGFloat.zero
    @Published var lowerAngleLimit = CGFloat.zero
    @Published var rotationSpeed = CGFloat.zero
    @Published var shouldEnableLimits = false
    @Published var upperAngleLimit = CGFloat.zero

    override func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJointPin.self)

        frictionTorque = joint.frictionTorque
        lowerAngleLimit = joint.lowerAngleLimit
        rotationSpeed = joint.rotationSpeed
        shouldEnableLimits = joint.shouldEnableLimits
        upperAngleLimit = joint.upperAngleLimit

        super.loadState(from: entity_)
    }
}

final class PhysicsJointSlidingRelay: PhysicsJointRelay {
    @Published var lowerDistanceLimit = CGFloat.zero
    @Published var shouldEnableLimits = false
    @Published var upperDistanceLimit = CGFloat.zero

    override func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJointSliding.self)

        lowerDistanceLimit = joint.lowerDistanceLimit
        shouldEnableLimits = joint.shouldEnableLimits
        upperDistanceLimit = joint.upperDistanceLimit

        super.loadState(from: entity_)
    }
}

final class PhysicsJointSpringRelay: PhysicsJointRelay {
    @Published var damping = CGFloat.zero
    @Published var frequency = CGFloat.zero

    override func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJointSpring.self)
        damping = joint.damping
        frequency = joint.frequency

        super.loadState(from: entity_)
    }
}
