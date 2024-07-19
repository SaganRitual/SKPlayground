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
    @ObservedObject var gameController: GameController
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager

    var body: some View {
        VStack {
            if gameController.selectedPhysicsField != nil {
                Text("\(gameController.physicsFieldRelay.fieldType.id) Field")
                    .underline()

                PhysicsFieldTogglesView(physicsFieldRelay: gameController.physicsFieldRelay)
                PhysicsFieldSlidersGrid(physicsFieldRelay: gameController.physicsFieldRelay)
                PhysicsFieldMasksView(
                    physicsFieldRelay: gameController.physicsFieldRelay,
                    physicsMaskNamesManager: physicsMaskNamesManager
                )
            }
        }
        .padding(.vertical)
    }
}
