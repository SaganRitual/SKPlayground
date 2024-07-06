// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

protocol PhysicsJointRelay: ObservableObject {
    var bodyA: SKPhysicsBody? { get set }
    var bodyB: SKPhysicsBody? { get set }
    var reactionForce: CGVector { get set }
    var reactionTorque: CGFloat { get set }
}

final class PhysicsJointFixedRelay: PhysicsJointRelay, ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero
}

final class PhysicsJointLimitRelay: PhysicsJointRelay, ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    @Published var maxLength = CGFloat.zero
}

final class PhysicsJointPinRelay: PhysicsJointRelay, ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    @Published var frictionTorque = CGFloat.zero
    @Published var lowerAngleLimit = CGFloat.zero
    @Published var rotationSpeed = CGFloat.zero
    @Published var shouldEnableLimits = false
    @Published var upperAngleLimit = CGFloat.zero
}

final class PhysicsJointSlidingRelay: PhysicsJointRelay, ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    @Published var lowerDistanceLimit = CGFloat.zero
    @Published var shouldEnableLimits = false
    @Published var upperDistanceLimit = CGFloat.zero
}

final class PhysicsJointSpringRelay: PhysicsJointRelay, ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    @Published var damping = CGFloat.zero
    @Published var frequency = CGFloat.zero
}
