// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsWorldConfigurator: View {
    @ObservedObject var selectedPhysicsRelay: SelectedPhysicsRelay

    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            if case let .world(physicsWorldRelay) = selectedPhysicsRelay.selected {
                Text("Physics World")
                    .underline()
                    .padding(.bottom)

                PhysicsWorldSlidersGrid(physicsWorldRelay: physicsWorldRelay)
                PhysicsWorldEdgeLoopView(physicsMaskNames: physicsMaskNames, physicsWorldRelay: physicsWorldRelay)
                PhysicsMaskNamesConfigurator(physicsMaskNames: physicsMaskNames)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsWorldConfigurator(selectedPhysicsRelay: SelectedPhysicsRelay(.world(PhysicsWorldRelay())))
}
