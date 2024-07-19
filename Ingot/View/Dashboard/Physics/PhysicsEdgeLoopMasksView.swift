// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsEdgeLoopMasksView: View {
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $physicsWorldRelay.enableEdgeLoop) {
                Text("Full Scene Edge Loop")
            }
            .toggleStyle(.checkbox)

            SKPMaskSelector<SKPhysicsBody>(
                $physicsWorldRelay.memberOf,
                fieldKeypath: \.categoryBitMask,
                label: Text("Member Of"),
                options: physicsMaskNamesManager.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $physicsWorldRelay.collideWith,
                fieldKeypath: \.collisionBitMask,
                label: Text("Collide With"),
                options: physicsMaskNamesManager.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $physicsWorldRelay.reportContactWith,
                fieldKeypath: \.contactTestBitMask,
                label: Text("Report Contact With"),
                options: physicsMaskNamesManager.names
            )
        }
        .padding()
    }
}
