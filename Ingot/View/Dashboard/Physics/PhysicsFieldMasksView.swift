// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldMasksView: View {
    @ObservedObject var physicsFieldRelay: PhysicsFieldRelay
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager

    var body: some View {
        VStack {
            SKPMaskSelector<SKFieldNode>(
                $physicsFieldRelay.applyTo,
                fieldKeypath: \.categoryBitMask,
                label: Text("Apply To"),
                options: physicsMaskNamesManager.names
            )
        }
        .padding([.top, .horizontal])
    }
}
