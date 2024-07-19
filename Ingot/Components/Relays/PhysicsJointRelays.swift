// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

class PhysicsJointRelay: ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    fileprivate var subscriptions = Set<AnyCancellable>()

    deinit {
        subscriptions.forEach { $0.cancel() }
    }

    class func selectedJoint(entityManager: EntityManager?) -> SKPhysicsJoint? {
        (entityManager?.singleSelected() as? SKPhysicsJoint)
    }

    func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJoint.self)
        reactionForce = joint.reactionForce
        reactionTorque = joint.reactionTorque
    }

    func subscribe(entityManager: EntityManager) { }
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

    override class func selectedJoint(entityManager: EntityManager?) -> SKPhysicsJointLimit? {
        super.selectedJoint(entityManager: entityManager) as? SKPhysicsJointLimit
    }

    override func subscribe(entityManager: EntityManager) {
        $maxLength.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.maxLength = $0
        }
        .store(in: &subscriptions)
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

    override class func selectedJoint(entityManager: EntityManager?) -> SKPhysicsJointPin? {
        super.selectedJoint(entityManager: entityManager) as? SKPhysicsJointPin
    }

    override func subscribe(entityManager: EntityManager) {
        $frictionTorque.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.frictionTorque = $0
        }
        .store(in: &subscriptions)

        $lowerAngleLimit.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.lowerAngleLimit = $0
        }
        .store(in: &subscriptions)

        $rotationSpeed.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.rotationSpeed = $0
        }
        .store(in: &subscriptions)

        $shouldEnableLimits.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.shouldEnableLimits = $0
        }
        .store(in: &subscriptions)

        $upperAngleLimit.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.upperAngleLimit = $0
        }
        .store(in: &subscriptions)
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

    override class func selectedJoint(entityManager: EntityManager?) -> SKPhysicsJointSliding? {
        super.selectedJoint(entityManager: entityManager) as? SKPhysicsJointSliding
    }

    override func subscribe(entityManager: EntityManager) {
        $lowerDistanceLimit.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.lowerDistanceLimit = $0
        }
        .store(in: &subscriptions)

        $shouldEnableLimits.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.shouldEnableLimits = $0
        }
        .store(in: &subscriptions)

        $upperDistanceLimit.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.upperDistanceLimit = $0
        }
        .store(in: &subscriptions)
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

    override class func selectedJoint(entityManager: EntityManager?) -> SKPhysicsJointSpring? {
        super.selectedJoint(entityManager: entityManager) as? SKPhysicsJointSpring
    }

    override func subscribe(entityManager: EntityManager) {
        $damping.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.damping = $0
        }
        .store(in: &subscriptions)

        $frequency.dropFirst().sink { [weak entityManager] in
            Self.selectedJoint(entityManager: entityManager)?.frequency = $0
        }
        .store(in: &subscriptions)
    }
}
