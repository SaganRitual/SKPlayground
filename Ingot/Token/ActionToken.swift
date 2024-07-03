// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

protocol ActionTokenProtocol {
    var duration: TimeInterval { get }
}

struct ActionTokenContainer: Identifiable {
    let id = UUID()
    let token: any ActionTokenProtocol

    static func randomToken() -> ActionTokenContainer {
        switch Int.random(in: 0..<8) {
        case 0:
            return ActionTokenContainer(token: FollowPathActionToken.randomToken())
        case 1:
            return ActionTokenContainer(token: MoveActionToken.randomToken())
        case 2:
            return ActionTokenContainer(token: RotateActionToken.randomToken())
        case 3:
            return ActionTokenContainer(token: ScaleActionToken.randomToken())
        case 4:
            return ActionTokenContainer(token: ForceActionToken.randomToken())
        case 5:
            return ActionTokenContainer(token: TorqueActionToken.randomToken())
        case 6:
            return ActionTokenContainer(token: ImpulseActionToken.randomToken())
        case 7:
            return ActionTokenContainer(token: AngularImpulseActionToken.randomToken())
        default:
            fatalError("Reputable accordion players insist this cannot happen")
        }
    }
}

struct FollowPathActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let path: [CGPoint]?
    let pathId: UUID?

    init(duration: TimeInterval, path: [CGPoint]) {
        self.duration = duration
        self.path = path
        self.pathId = nil
    }

    init(duration: TimeInterval, pathId: UUID) {
        self.duration = duration
        self.path = nil
        self.pathId = pathId
    }

    static func randomToken() -> FollowPathActionToken {
        FollowPathActionToken(
            duration: .random(in: (1.0 / 60)...10),
            path: (0..<5).map { _ in CGPoint.random(in: -100...100) }
        )
    }
}

struct MoveActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let targetPosition: CGPoint

    static func randomToken() -> MoveActionToken {
        MoveActionToken(
            duration: .random(in: (1.0 / 60)...10),
            targetPosition: CGPoint(x: .random(in: -100...100), y: .random(in: -100...100))
        )
    }
}

struct RotateActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let targetRotation: CGFloat

    static func randomToken() -> RotateActionToken {
        RotateActionToken(
            duration: .random(in: (1.0 / 60)...10),
            targetRotation: .random(in: (-2 * .pi)...(2 * .pi))
        )
    }
}

struct ScaleActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let targetScale: CGFloat

    static func randomToken() -> ScaleActionToken {
        ScaleActionToken(
            duration: .random(in: (1.0 / 60)...10),
            targetScale: .random(in: 1...10)
        )
    }
}

struct ForceActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let focus: CGPoint
    let force: CGVector

    static func randomToken() -> ForceActionToken {
        ForceActionToken(
            duration: .random(in: (1.0 / 60)...10),
            focus: CGPoint(x: .random(in: -100...100), y: .random(in: -100...100)),
            force: CGVector(dx: .random(in: -100...100), dy: .random(in: -100...100))
        )
    }
}

struct TorqueActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let torque: CGFloat

    static func randomToken() -> TorqueActionToken {
        TorqueActionToken(
            duration: .random(in: (1.0 / 60)...10),
            torque: .random(in: -100...100)
        )
    }
}

struct ImpulseActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let focus: CGPoint
    let impulse: CGVector

    static func randomToken() -> ImpulseActionToken {
        ImpulseActionToken(
            duration: .random(in: (1.0 / 60)...10),
            focus: CGPoint(x: .random(in: -100...100), y: .random(in: -100...100)),
            impulse: CGVector(dx: .random(in: -100...100), dy: .random(in: -100...100))
        )
    }
}

struct AngularImpulseActionToken: ActionTokenProtocol {
    let duration: TimeInterval
    let angularImpulse: CGFloat

    static func randomToken() -> AngularImpulseActionToken {
        AngularImpulseActionToken(
            duration: .random(in: (1.0 / 60)...10),
            angularImpulse: .random(in: -100...100)
        )
    }
}
