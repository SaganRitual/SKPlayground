// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointConfigurator: View {
    @EnvironmentObject var selectedPhysicsRelay: SelectedPhysicsRelay

    var body: some View {
        ZStack {
            switch selectedPhysicsRelay.selected {
            case .jointFixed(let fixedRelay):
                PhysicsJointFixedView(relay: fixedRelay)
            case .jointLimit(let limitRelay):
                PhysicsJointLimitView(relay: limitRelay)
            case .jointPin(let pinRelay):
                PhysicsJointPinView(relay: pinRelay)
            case .jointSliding(let slidingRelay):
                PhysicsJointSlidingView(relay: slidingRelay)
            case .jointSpring(let springRelay):
                PhysicsJointSpringView(relay: springRelay)

            case .none:
                Text("No Joint Selected, or Multiple Joints Selected")

            default:
                fatalError("How did we get here?")
            }
        }
        .padding()
    }
}

#Preview {
    PhysicsJointConfigurator()
        .environmentObject(SelectedPhysicsRelay(.jointSpring(PhysicsJointSpringRelay())))
}
