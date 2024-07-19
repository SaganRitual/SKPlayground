// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyConfigurator: View {
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager
    @ObservedObject var selectedPhysicsRelay: SelectedPhysicsRelay

    var body: some View {
        VStack {
            if case let .body(physicsBodyRelay) = selectedPhysicsRelay.selected {
                Text("Body")
                    .underline()

                PhysicsBodyTogglesView(physicsBodyRelay: physicsBodyRelay)
                PhysicsBodySlidersGrid(physicsBodyRelay: physicsBodyRelay)
                PhysicsBodyMasksView(
                    physicsBodyRelay: physicsBodyRelay,
                    physicsMaskNamesManager: physicsMaskNamesManager
                )
            }
        }
        .padding(.vertical)
    }
}
