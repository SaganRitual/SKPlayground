// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

enum PhysicsJointType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case fixed = "Fixed", limit = "Limit", pin = "Pin", sliding = "Sliding", spring = "Spring"
}

struct PhysicsJointConfigurator: View {
    @ObservedObject var gameController: GameController

    var body: some View {
        ZStack {
            if let joint = gameController.selectedPhysicsJoint {
                Text("\(gameController.physicsJointRelay.jointType.rawValue.capitalized) Joint")
                    .underline()

                switch joint.physicsJoint {
                case is SKPhysicsJointFixed:
                    PhysicsJointFixedView(
                        relay: Utility.forceCast(gameController.physicsJointRelay, to: PhysicsJointFixedRelay.self)
                    )

                case is SKPhysicsJointLimit:
                    PhysicsJointLimitView(
                        relay: Utility.forceCast(gameController.physicsJointRelay, to: PhysicsJointLimitRelay.self)
                    )

                case is SKPhysicsJointPin:
                    PhysicsJointPinView(
                        relay: Utility.forceCast(gameController.physicsJointRelay, to: PhysicsJointPinRelay.self)
                    )

                case is SKPhysicsJointSliding:
                    PhysicsJointSlidingView(
                        relay: Utility.forceCast(gameController.physicsJointRelay, to: PhysicsJointSlidingRelay.self)
                    )

                case is SKPhysicsJointSpring:
                    PhysicsJointSpringView(
                        relay: Utility.forceCast(gameController.physicsJointRelay, to: PhysicsJointSpringRelay.self)
                    )

                default:
                    fatalError("We thought this couldn't happen")
                }
            }
        }
        .padding()
    }
}
