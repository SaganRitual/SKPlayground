// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldConfigurator: View {
    @EnvironmentObject var selectedPhysicsRelay: SelectedPhysicsRelay

    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            if case let .field(physicsFieldRelay) = selectedPhysicsRelay.selected {
                PhysicsFieldTogglesView(physicsFieldRelay: physicsFieldRelay)
                PhysicsFieldSlidersView(physicsFieldRelay: physicsFieldRelay)
                PhysicsFieldMasksView(physicsMaskNames: physicsMaskNames)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsFieldConfigurator()
        .environmentObject(SelectedPhysicsRelay(.field(PhysicsFieldRelay())))
}
