// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsBodyTogglesView: View {
    @ObservedObject var physicsBodyRelay: PhysicsBodyRelay

    var body: some View {
        HStack(spacing: 50) {
            SKPToggle<SKPhysicsBody>(
                isOn: $physicsBodyRelay.isDynamic, fieldKeypath: \.isDynamic, title: "Apply Physics"
            )

            SKPToggle<SKPhysicsBody>(
                isOn: $physicsBodyRelay.affectedByGravity, fieldKeypath: \.affectedByGravity, title: "Apply Gravity"
            )

            SKPToggle<SKPhysicsBody>(
                isOn: $physicsBodyRelay.allowsRotation, fieldKeypath: \.allowsRotation, title: "Allow Rotation"
            )
        }
        .padding()
    }
}

#Preview {
    PhysicsBodyTogglesView(physicsBodyRelay: PhysicsBodyRelay())
}
