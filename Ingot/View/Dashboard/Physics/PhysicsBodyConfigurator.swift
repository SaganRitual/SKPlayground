// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyConfigurator: View {
    @EnvironmentObject var selectedPhysicsRelay: SelectedPhysicsRelay

    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            if case let .body(physicsBodyRelay) = selectedPhysicsRelay.selected {
                PhysicsBodyTogglesView(physicsBodyRelay: physicsBodyRelay)
                PhysicsBodySlidersGrid(physicsBodyRelay: physicsBodyRelay)
                PhysicsBodyMasksView(physicsMaskNames: physicsMaskNames)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsBodyConfigurator()
        .environmentObject(SelectedPhysicsRelay(.body(PhysicsBodyRelay())))
}
