// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointConfigurator: View {
    @EnvironmentObject var gameController: GameController

    @StateObject var fixedRelay = PhysicsJointFixedRelay()
    @StateObject var limitRelay = PhysicsJointLimitRelay()
    @StateObject var pinRelay = PhysicsJointPinRelay()
    @StateObject var slidingRelay = PhysicsJointSlidingRelay()
    @StateObject var springRelay = PhysicsJointSpringRelay()

    var body: some View {
        ZStack {
            switch gameController.soleSelectedJoint {
            case is SKPhysicsJointFixed:
                PhysicsJointFixedView(relay: fixedRelay)
            case is SKPhysicsJointLimit:
                PhysicsJointLimitView(relay: limitRelay)
            case is SKPhysicsJointPin:
                PhysicsJointPinView(relay: pinRelay)
            case is SKPhysicsJointSliding:
                PhysicsJointSlidingView(relay: slidingRelay)
            case is SKPhysicsJointSpring:
                PhysicsJointSpringView(relay: springRelay)

            case .none:
                Text("No Joint Selected, or Multiple Joints Selected")

            default:
                fatalError("Unable to configure physics joint of type \(type(of:gameController.soleSelectedJoint))")
            }
        }
        .padding()
    }
}

#Preview {
    @StateObject var gameController = GameController()

    return PhysicsJointConfigurator()
        .environmentObject(gameController)
}
