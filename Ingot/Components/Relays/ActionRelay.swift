// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation

final class ActionRelay: ObservableObject {
    @Published var duration = TimeInterval.zero
    @Published var forceDX = CGFloat.zero
    @Published var forceDY = CGFloat.zero
    @Published var positionX = CGFloat.zero
    @Published var positionY = CGFloat.zero
    @Published var torque = CGFloat.zero

    private var subscriptions = Set<AnyCancellable>()

    var focus: CGPoint {
        get { CGPoint(x: positionX, y: positionY) }
        set { positionX = newValue.x; positionY = newValue.y }
    }

    var force: CGVector {
        get { CGVector(dx: forceDX, dy: forceDY) }
        set { forceDX = newValue.dx; forceDY = newValue.dy }
    }

    func loadState(from entity_: GameEntity) {
        let entity = Utility.forceCast(entity_, to: Gremlin.self)
        if let action = entity.selectedAction {
            self.duration = action.duration
        }

        switch entity.selectedAction {
        case let fat as ForceActionToken:
            self.forceDX = fat.forceDX
            self.forceDY = fat.forceDY
            self.positionX = fat.positionX
            self.positionY = fat.positionY

        case let iat as ImpulseActionToken:
            self.forceDX = iat.forceDX
            self.forceDY = iat.forceDY
            self.positionX = iat.positionX
            self.positionY = iat.positionY

        case let tat as TorqueActionToken:
            self.torque = tat.torque

        case let aat as AngularImpulseActionToken:
            self.torque = aat.torque

        default:
            fatalError("We thought this couldn't happen")
        }
    }

    func subscribe(gameController: GameController) {
        $forceDX.dropFirst().sink { [weak gameController] in
            var token = Utility.forceCast(gameController?.selectedAction, to: ForceIshActionToken.self)
            token.forceDX = $0
        }
        .store(in: &subscriptions)

        $forceDY.dropFirst().sink { [weak gameController] in
            var token = Utility.forceCast(gameController?.selectedAction, to: ForceIshActionToken.self)
            token.forceDY = $0
        }
        .store(in: &subscriptions)

        $positionX.dropFirst().sink { [weak gameController] in
            var token = Utility.forceCast(gameController?.selectedAction, to: ForceIshActionToken.self)
            token.positionX = $0
        }
        .store(in: &subscriptions)

        $positionY.dropFirst().sink { [weak gameController] in
            var token = Utility.forceCast(gameController?.selectedAction, to: ForceIshActionToken.self)
            token.positionY = $0
        }
        .store(in: &subscriptions)

        $torque.dropFirst().sink { [weak gameController] in
            var token = Utility.forceCast(gameController?.selectedAction, to: TorqueIshActionToken.self)
            token.torque = $0
        }
        .store(in: &subscriptions)

        $duration.dropFirst().sink { [weak gameController] in
            Utility.forceUnwrap(gameController?.selectedAction).duration = $0
        }
        .store(in: &subscriptions)
    }
}
