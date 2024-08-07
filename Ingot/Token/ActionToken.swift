// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

enum ActionType: CaseIterable {
    case followPath, move, rotate, scale
    case force, torque, impulse, angularImpulse

    var isPhysics: Bool {
        switch self {
        case .angularImpulse: fallthrough
        case .force: fallthrough
        case .impulse: fallthrough
        case .torque: return true

        default: return false
        }
    }

    var isSpace: Bool { !isPhysics }
}

class ActionToken: ObservableObject, Identifiable {
    let id = UUID()
    let actionType: ActionType

    @Published var duration: TimeInterval

    var isPhysicsAction: Bool { actionType.isPhysics }
    var isSpaceAction: Bool { actionType.isSpace }

    init(actionType: ActionType, duration: TimeInterval) {
        self.actionType = actionType
        self.duration = duration
    }

    func makeSKAction() -> SKAction { fatalError("Not implemented for this action token?") }

    class func randomToken() -> ActionToken {
        let duration = TimeInterval.random(in: 1...5)

        switch Utility.forceUnwrap(ActionType.allCases.randomElement()) {
        case .angularImpulse:
            return AngularImpulseActionToken(duration: duration, torque: CGFloat.random(in: (-2 * .pi)...(+2 * .pi)))
        case .followPath:
            return FollowPathActionToken(duration: duration)

        case .force:
            return ForceActionToken(
                duration: duration, force: CGVector.random(in: (-100)...(+100)), focus: CGPoint.random(in: -1...1)
            )

        case .impulse:
            return ImpulseActionToken(
                duration: duration, force: CGVector.random(in: (-100)...(+100)), focus: CGPoint.random(in: -1...1)
            )

        case .move:
            return MoveActionToken(duration: duration, targetPosition: CGPoint.random(in: (-100)...(+100)))
        case .rotate:
            return RotateActionToken(duration: duration, targetRotation: CGFloat.random(in: (-2 * .pi)...(+2 * .pi)))
        case .scale:
            return ScaleActionToken(duration: duration, targetScale: CGFloat.random(in: 1...2))
        case .torque:
            return TorqueActionToken(duration: duration, torque: CGFloat.random(in: (-2 * .pi)...(+2 * .pi)))
        }
    }
}

extension ActionToken: Equatable {
    static func == (lhs: ActionToken, rhs: ActionToken) -> Bool {
        lhs === rhs
    }
}

final class FollowPathActionToken: ActionToken {
    @Published var pathId: UUID?

    init(duration: TimeInterval) {
        super.init(actionType: .followPath, duration: duration)
    }
}

final class MoveActionToken: ActionToken {
    @Published var targetPosition = CGPoint.zero

    init(duration: TimeInterval, targetPosition: CGPoint) {
        self.targetPosition = targetPosition
        super.init(actionType: .move, duration: duration)
    }
}

final class RotateActionToken: ActionToken {
    @Published var targetRotation = CGFloat.zero

    init(duration: TimeInterval, targetRotation: CGFloat = 1) {
        self.targetRotation = targetRotation
        super.init(actionType: .rotate, duration: duration)
    }
}

final class ScaleActionToken: ActionToken {
    @Published var targetScale: CGFloat

    init(duration: TimeInterval, targetScale: CGFloat = 1) {
        self.targetScale = targetScale
        super.init(actionType: .scale, duration: duration)
    }
}

protocol ForceIshActionToken {
    var forceDX: CGFloat { get set }
    var forceDY: CGFloat { get set }
    var positionX: CGFloat { get set }
    var positionY: CGFloat { get set }
}

extension ForceIshActionToken {
    var focus: CGPoint { CGPoint(x: positionX, y: positionY) }
    var force: CGVector { CGVector(dx: forceDX, dy: forceDY) }
}

final class ForceActionToken: ActionToken, ForceIshActionToken {
    @Published var forceDX: CGFloat
    @Published var forceDY: CGFloat
    @Published var positionX: CGFloat
    @Published var positionY: CGFloat

    init(randomValues: Bool = false) {
        forceDX = randomValues ? .random(in: (-10)...(10)) : .zero
        forceDY = randomValues ? .random(in: (-10)...(10)) : .zero
        positionX = randomValues ? .random(in: (-1)...(1)) : .zero
        positionY = randomValues ? .random(in: (-1)...(1)) : .zero

        super.init(actionType: .force, duration: randomValues ? .random(in: (0.01)...(5)) : 0.01)
    }

    init(duration: TimeInterval, force: CGVector, focus: CGPoint) {
        self.forceDX = force.dx
        self.forceDY = force.dy
        self.positionX = focus.x
        self.positionY = focus.y
        super.init(actionType: .force, duration: duration)
    }

    override func makeSKAction() -> SKAction {
        SKAction.applyForce(force, duration: duration)
    }
}

protocol TorqueIshActionToken {
    var torque: CGFloat { get set }
}

final class TorqueActionToken: ActionToken, TorqueIshActionToken {
    @Published var torque: CGFloat

    init(randomValues: Bool = false) {
        self.torque = randomValues ? .random(in: (-2 * .pi)...(2 * .pi)) : .zero
        super.init(actionType: .torque, duration: 0.01)
    }

    init(duration: TimeInterval, torque: CGFloat) {
        self.torque = torque
        super.init(actionType: .torque, duration: duration)
    }

    override func makeSKAction() -> SKAction {
        SKAction.applyTorque(torque, duration: duration)
    }
}

final class ImpulseActionToken: ActionToken, ForceIshActionToken {
    @Published var forceDX: CGFloat
    @Published var forceDY: CGFloat
    @Published var positionX: CGFloat
    @Published var positionY: CGFloat

    init(randomValues: Bool = false) {
        forceDX = randomValues ? .random(in: (-10)...(10)) : .zero
        forceDY = randomValues ? .random(in: (-10)...(10)) : .zero
        positionX = randomValues ? .random(in: (-1)...(1)) : .zero
        positionY = randomValues ? .random(in: (-1)...(1)) : .zero

        super.init(actionType: .impulse, duration: randomValues ? .random(in: (0.01)...(5)) : 0.01)
    }

    init(duration: TimeInterval, force: CGVector, focus: CGPoint) {
        self.forceDX = force.dx
        self.forceDY = force.dy
        self.positionX = focus.x
        self.positionY = focus.y
        super.init(actionType: .impulse, duration: duration)
    }

    override func makeSKAction() -> SKAction {
        SKAction.applyImpulse(force, duration: duration)
    }
}

final class AngularImpulseActionToken: ActionToken, TorqueIshActionToken {
    @Published var torque: CGFloat

    init(randomValues: Bool = false) {
        self.torque = randomValues ? .random(in: (-2 * .pi)...(2 * .pi)) : .zero
        super.init(actionType: .angularImpulse, duration: 0.01)
    }

    init(duration: TimeInterval, torque: CGFloat) {
        self.torque = torque
        super.init(actionType: .angularImpulse, duration: duration)
    }

    override func makeSKAction() -> SKAction {
        SKAction.applyAngularImpulse(torque, duration: duration)
    }
}
