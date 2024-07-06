// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointSpringView: View {
    @ObservedObject var relay: PhysicsJointSpringRelay

    var body: some View {
        VStack {
            PhysicsJointCommonView(relay: relay)

            SKPSliderWithRelay<SKPhysicsJointSpring, CGFloat, Text, Text>(
                $relay.damping,
                fieldKeypath: \.damping,
                range: 0...100,
                scalarView: Text(String(format: "%.2f", relay.damping)),
                titleView: Text("Damping: Energy Loss per Oscillation")
            )

            SKPSliderWithRelay<SKPhysicsJointSpring, CGFloat, Text, Text>(
                $relay.frequency,
                fieldKeypath: \.frequency,
                range: 0...100,
                scalarView: Text(String(format: "%.2f", relay.frequency)),
                titleView: Text("Oscillation Frequency Hz")
            )
        }
    }
}
