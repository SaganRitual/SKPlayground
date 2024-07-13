// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsWorldEdgeLoopView: View {
//    @EnvironmentObject var gameController: GameController

    @ObservedObject var physicsMaskNames: PhysicsMaskNames
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    @State private var collideWith = Set<Int>()
    @State private var reportContactWith = Set<Int>()

    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $physicsWorldRelay.enableEdgeLoop) {
                Text("Full Scene Edge Loop")
            }
            .toggleStyle(.checkbox)

            SKPMaskSelector<SKPhysicsBody>(
                $collideWith,
                fieldKeypath: \.collisionBitMask,
                label: Text("Collide With"),
                options: physicsMaskNames.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $reportContactWith,
                fieldKeypath: \.contactTestBitMask,
                label: Text("Report Contact With"),
                options: physicsMaskNames.names
            )
        }
        .padding()
    }
}

//#Preview {
//    PhysicsWorldEdgeLoopView(physicsMaskNames: PhysicsMaskNames(), physicsWorldRelay: PhysicsWorldRelay())
//}
