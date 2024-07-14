// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

enum PhysicsFieldType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case drag = "Drag", electric = "Electric", linearGravity = "Linear Gravity"
    case magnetic = "Magnetic", noise = "Noise", radialGravity = "Radial Gravity"
    case spring = "Spring", turbulence = "Turbulence", velocity = "Velocity"
    case vortex = "Vortex"
}

struct PhysicsFieldConfigurator: View {
    @ObservedObject var selectedPhysicsRelay: SelectedPhysicsRelay

    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            if case let .field(physicsFieldRelay) = selectedPhysicsRelay.selected {
                Text("Physics Field")
                    .underline()
                    .padding(.bottom)

                PhysicsFieldTogglesView(physicsFieldRelay: physicsFieldRelay)
                PhysicsFieldSlidersGrid(physicsFieldRelay: physicsFieldRelay)
                PhysicsFieldMasksView(physicsMaskNames: physicsMaskNames)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsFieldConfigurator(selectedPhysicsRelay: SelectedPhysicsRelay(.field(PhysicsFieldRelay())))
}
