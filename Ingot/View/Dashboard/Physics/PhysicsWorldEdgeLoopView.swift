// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsWorldEdgeLoopView: View {
    @EnvironmentObject var gameController: GameController

    @ObservedObject var physicsMaskNames: PhysicsMaskNames
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $physicsWorldRelay.enableEdgeLoop) {
                Text("Full Scene Edge Loop")
            }
            .toggleStyle(.checkbox)

            CheckboxPicker(
                selectedIndices: $physicsWorldRelay.selectedCollisionIndices,
                label: Text("Collide With"),
                options: physicsMaskNames.names
            )

            CheckboxPicker(
                selectedIndices: $physicsWorldRelay.selectedContactIndices,
                label: Text("Report Contact With"),
                options: physicsMaskNames.names
            )
        }
        .padding()
    }
}

#Preview {
    PhysicsWorldEdgeLoopView(physicsMaskNames: PhysicsMaskNames(), physicsWorldRelay: PhysicsWorldRelay())
}
