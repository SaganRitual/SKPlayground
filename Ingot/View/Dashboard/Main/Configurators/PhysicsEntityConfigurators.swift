// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsEntityConfigurators: View {
    @ObservedObject var gameController: GameController
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager

    var body: some View {
        ZStack {
            if gameController.singleSelected() == nil {
                Text("No entity selected; select a Field, Gremlin, or Joint")
            } else {
                PhysicsBodyConfigurator(
                    gameController: gameController,
                    physicsMaskNamesManager: physicsMaskNamesManager
                )

                PhysicsFieldConfigurator(
                    gameController: gameController,
                    physicsMaskNamesManager: physicsMaskNamesManager
                )

                PhysicsJointConfigurator(gameController: gameController)
            }
        }
    }
}
