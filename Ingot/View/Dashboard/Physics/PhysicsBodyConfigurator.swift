// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyConfigurator: View {
    @EnvironmentObject var gameController: GameController

    @StateObject var physicsBodyRelay = PhysicsBodyRelay()
    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            PhysicsBodyTogglesView(physicsBodyRelay: physicsBodyRelay)
            PhysicsBodySlidersView(physicsBodyRelay: physicsBodyRelay)
            PhysicsBodyMasksView(physicsMaskNames: physicsMaskNames)
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsBodyConfigurator()
        .environmentObject(GameController())
}
