// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodyConfigurator: View {
    @ObservedObject var gameController: GameController
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager

    var body: some View {
        VStack {
            if gameController.selectedPhysicsBody != nil {
                Text("Body")
                    .underline()

                PhysicsBodyTogglesView(physicsBodyRelay: gameController.physicsBodyRelay)
                PhysicsBodySlidersGrid(physicsBodyRelay: gameController.physicsBodyRelay)
                PhysicsBodyMasksView(
                    physicsBodyRelay: gameController.physicsBodyRelay,
                    physicsMaskNamesManager: physicsMaskNamesManager
                )
            }
        }
        .padding(.vertical)
    }
}
