// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class ActionRelay: ObservableObject {
    @Published var duration = TimeInterval.zero
    @Published var forceDX = CGFloat.zero
    @Published var forceDY = CGFloat.zero
    @Published var positionX = CGFloat.zero
    @Published var positionY = CGFloat.zero
    @Published var torque = CGFloat.zero

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
}
