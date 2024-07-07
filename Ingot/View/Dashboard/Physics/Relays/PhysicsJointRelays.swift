// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsJointRelay: ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero
}

final class PhysicsJointFixedRelay: PhysicsJointRelay {
}

final class PhysicsJointLimitRelay: PhysicsJointRelay {
    @Published var maxLength = CGFloat.zero
}

final class PhysicsJointPinRelay: PhysicsJointRelay {
    @Published var frictionTorque = CGFloat.zero
    @Published var lowerAngleLimit = CGFloat.zero
    @Published var rotationSpeed = CGFloat.zero
    @Published var shouldEnableLimits = false
    @Published var upperAngleLimit = CGFloat.zero
}

final class PhysicsJointSlidingRelay: PhysicsJointRelay {
    @Published var lowerDistanceLimit = CGFloat.zero
    @Published var shouldEnableLimits = false
    @Published var upperDistanceLimit = CGFloat.zero
}

final class PhysicsJointSpringRelay: PhysicsJointRelay {
    @Published var damping = CGFloat.zero
    @Published var frequency = CGFloat.zero
}
