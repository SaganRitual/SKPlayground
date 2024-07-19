// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsEntityConfigurators: View {
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager
    @ObservedObject var selectedPhysicsRelay: SelectedPhysicsRelay

    var body: some View {
        ZStack {
            if selectedPhysicsRelay.selected == nil {
                Text("No entity selected; select a Field, Gremlin, or Joint")
            } else {
                PhysicsBodyConfigurator(
                    physicsMaskNamesManager: physicsMaskNamesManager,
                    selectedPhysicsRelay: selectedPhysicsRelay
                )

                PhysicsFieldConfigurator(
                    physicsMaskNamesManager: physicsMaskNamesManager,
                    selectedPhysicsRelay: selectedPhysicsRelay
                )

                PhysicsJointConfigurator(selectedPhysicsRelay: selectedPhysicsRelay)
            }
        }
    }
}
