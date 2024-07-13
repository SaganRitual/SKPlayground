// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsBodyMasksView: View {
//    @EnvironmentObject var gameController: GameController

    @ObservedObject var physicsMaskNames: PhysicsMaskNames

    @State private var applyFields = Set<Int>()
    @State private var collideWith = Set<Int>()
    @State private var reportContactWith = Set<Int>()

    var body: some View {
        VStack {
            SKPMaskSelector<SKPhysicsBody>(
                $applyFields,
                fieldKeypath: \.fieldBitMask,
                label: Text("Apply Fields"),
                options: physicsMaskNames.names
            )

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
        .padding([.top, .horizontal])
    }
}

//#Preview {
//    PhysicsBodyMasksView(physicsMaskNames: PhysicsMaskNames())
//        .environmentObject(GameController())
//}
