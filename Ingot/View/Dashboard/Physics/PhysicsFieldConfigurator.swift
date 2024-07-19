// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

enum PhysicsFieldType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue.capitalized }

    case drag = "Drag", electric = "Electric", linearGravity = "Linear Gravity"
    case magnetic = "Magnetic", noise = "Noise", radialGravity = "Radial Gravity"
    case spring = "Spring", turbulence = "Turbulence", velocity = "Velocity"
    case vortex = "Vortex"
}

struct PhysicsFieldConfigurator: View {
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager
    @ObservedObject var selectedPhysicsRelay: SelectedPhysicsRelay

    var body: some View {
        VStack {
            if case let .field(physicsFieldRelay) = selectedPhysicsRelay.selected {
                Text("\(physicsFieldRelay.fieldType.id) Field")
                    .underline()

                PhysicsFieldTogglesView(physicsFieldRelay: physicsFieldRelay)
                PhysicsFieldSlidersGrid(physicsFieldRelay: physicsFieldRelay)
                PhysicsFieldMasksView(
                    physicsFieldRelay: physicsFieldRelay,
                    physicsMaskNamesManager: physicsMaskNamesManager
                )
            }
        }
        .padding(.vertical)
    }
}
