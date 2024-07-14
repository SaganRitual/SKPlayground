// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyConfigurator: View {
    @ObservedObject var selectedPhysicsRelay: SelectedPhysicsRelay

    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            if case let .body(physicsBodyRelay) = selectedPhysicsRelay.selected {
                Text("Physics Body")
                    .underline()
                    .padding(.bottom)

                PhysicsBodyTogglesView(physicsBodyRelay: physicsBodyRelay)
                PhysicsBodySlidersGrid(physicsBodyRelay: physicsBodyRelay)
                PhysicsBodyMasksView(physicsMaskNames: physicsMaskNames)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsBodyConfigurator(selectedPhysicsRelay: SelectedPhysicsRelay(.body(PhysicsBodyRelay())))
}
