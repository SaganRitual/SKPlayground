// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsWorldConfigurator: View {
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    var body: some View {
        VStack {
            Text("Physics World")
                .underline()
                .padding(.bottom)

            PhysicsWorldSlidersGrid(physicsWorldRelay: physicsWorldRelay)
            PhysicsEdgeLoopMasksView(physicsMaskNamesManager: physicsMaskNamesManager, physicsWorldRelay: physicsWorldRelay)
            PhysicsMaskNamesConfigurator(physicsMaskNamesManager: physicsMaskNamesManager)
        }
        .padding(.vertical)
    }
}
