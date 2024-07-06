// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldConfigurator: View {
    @StateObject var physicsFieldRelay = PhysicsFieldRelay()
    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            PhysicsFieldTogglesView(physicsFieldRelay: physicsFieldRelay)
            PhysicsFieldSlidersView(physicsFieldRelay: physicsFieldRelay)
            PhysicsFieldMasksView(physicsMaskNames: physicsMaskNames)
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsFieldConfigurator()
}
