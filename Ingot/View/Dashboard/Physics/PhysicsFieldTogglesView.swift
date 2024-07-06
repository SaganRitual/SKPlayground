// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldTogglesView: View {
    @ObservedObject var physicsFieldRelay: PhysicsFieldRelay

    var body: some View {
        HStack(spacing: 50) {
            SKPToggle<SKFieldNode>(
                isOn: $physicsFieldRelay.enabled,
                fieldKeypath: \.isEnabled,
                title: "Enabled"
            )

            SKPToggle<SKFieldNode>(
                isOn: $physicsFieldRelay.exclusive,
                fieldKeypath: \.isExclusive,
                title: "Exclusive"
            )
        }
        .padding()
    }
}
