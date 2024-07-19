// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

class PhysicsJointRelay: ObservableObject {
    weak var bodyA: SKPhysicsBody?
    weak var bodyB: SKPhysicsBody?

    @Published var jointType: PhysicsJointType = .allCases.randomElement()!
    @Published var reactionForce = CGVector.zero
    @Published var reactionTorque = CGFloat.zero

    fileprivate var subscriptions = Set<AnyCancellable>()

    deinit {
        subscriptions.forEach { $0.cancel() }
    }

    func loadState(from entity_: GameEntity) {
        let joint = Utility.forceCast(entity_, to: SKPhysicsJoint.self)
        reactionForce = joint.reactionForce
        reactionTorque = joint.reactionTorque
    }

    func subscribe(gameController: GameController) { }
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

    override func subscribe(gameController: GameController) {
        $maxLength.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointLimit.self)
            joint.maxLength = $0
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

    override func subscribe(gameController: GameController) {
        $frictionTorque.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointPin.self)
            joint.frictionTorque = $0
        }
        .store(in: &subscriptions)

        $lowerAngleLimit.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointPin.self)
            joint.lowerAngleLimit = $0
        }
        .store(in: &subscriptions)

        $rotationSpeed.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointPin.self)
            joint.rotationSpeed = $0
        }
        .store(in: &subscriptions)

        $shouldEnableLimits.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointPin.self)
            joint.shouldEnableLimits = $0
        }
        .store(in: &subscriptions)

        $upperAngleLimit.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointPin.self)
            joint.upperAngleLimit = $0
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

    override func subscribe(gameController: GameController) {
        $lowerDistanceLimit.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointSliding.self)
            joint.lowerDistanceLimit = $0
        }
        .store(in: &subscriptions)

        $shouldEnableLimits.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointSliding.self)
            joint.shouldEnableLimits = $0
        }
        .store(in: &subscriptions)

        $upperDistanceLimit.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointSliding.self)
            joint.upperDistanceLimit = $0
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

    override func subscribe(gameController: GameController) {
        $damping.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointSpring.self)
            joint.damping = $0
        }
        .store(in: &subscriptions)

        $frequency.dropFirst().sink { [weak gameController] in
            let joint = Utility.forceCast(gameController?.selectedPhysicsJoint, to: SKPhysicsJointSpring.self)
            joint.frequency = $0
        }
        .store(in: &subscriptions)
    }
}
