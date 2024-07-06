// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldMasksView: View {
    @EnvironmentObject var gameController: GameController

    @ObservedObject var physicsMaskNames: PhysicsMaskNames

    @State private var applyToBodies = Set<Int>()

    var body: some View {
        VStack {
            SKPMaskSelector<SKFieldNode>(
                $applyToBodies,
                fieldKeypath: \.categoryBitMask,
                label: Text("Apply To"),
                options: physicsMaskNames.names
            )
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    PhysicsFieldMasksView(physicsMaskNames: PhysicsMaskNames())
        .environmentObject(GameController())
}
