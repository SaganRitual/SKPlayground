// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointLimitView: View {
    @ObservedObject var relay: PhysicsJointLimitRelay

    var body: some View {
        VStack {
            PhysicsJointCommonView(relay: relay)

            SKPSliderWithRelay<SKPhysicsJointLimit, CGFloat, Text, Text>(
                $relay.maxLength,
                fieldKeypath: \.maxLength,
                range: -2...2,
                scalarView: Text(String(format: "%.2f", relay.maxLength)),
                titleView: Text("Max Length")
            )
            .padding(.top)
        }
    }
}
