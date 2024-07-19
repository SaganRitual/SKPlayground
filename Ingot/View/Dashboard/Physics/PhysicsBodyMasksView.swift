// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsBodyMasksView: View {
    @ObservedObject var physicsBodyRelay: PhysicsBodyRelay
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager

    var body: some View {
        VStack {
            SKPMaskSelector<SKPhysicsBody>(
                $physicsBodyRelay.memberOf,
                fieldKeypath: \.categoryBitMask,
                label: Text("Member Of"),
                options: physicsMaskNamesManager.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $physicsBodyRelay.applyFields,
                fieldKeypath: \.fieldBitMask,
                label: Text("Apply Fields"),
                options: physicsMaskNamesManager.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $physicsBodyRelay.collideWith,
                fieldKeypath: \.collisionBitMask,
                label: Text("Collide With"),
                options: physicsMaskNamesManager.names
            )

            SKPMaskSelector<SKPhysicsBody>(
                $physicsBodyRelay.reportContactWith,
                fieldKeypath: \.contactTestBitMask,
                label: Text("Report Contact With"),
                options: physicsMaskNamesManager.names
            )
        }
        .padding([.top, .horizontal])
    }
}
