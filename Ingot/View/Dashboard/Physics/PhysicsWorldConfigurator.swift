// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsWorldConfigurator: View {
    @EnvironmentObject var selectedPhysicsRelay: SelectedPhysicsRelay

    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            if case let .world(physicsWorldRelay) = selectedPhysicsRelay.selected {
                PhysicsWorldSlidersGrid(physicsWorldRelay: physicsWorldRelay)
                PhysicsWorldEdgeLoopView(physicsMaskNames: physicsMaskNames, physicsWorldRelay: physicsWorldRelay)
                PhysicsMaskNamesConfigurator(physicsMaskNames: physicsMaskNames)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsWorldConfigurator()
        .environmentObject(SelectedPhysicsRelay(.world(PhysicsWorldRelay())))
}
