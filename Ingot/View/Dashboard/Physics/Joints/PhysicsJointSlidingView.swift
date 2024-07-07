// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointSlidingView: View {
    @ObservedObject var relay: PhysicsJointSlidingRelay

    var body: some View {
        VStack {
            PhysicsJointCommonView(relay: relay)

            HStack {
                Text("Distance Limits")
                    .underline()

                SKPToggle<SKPhysicsJointSliding>(
                    isOn: $relay.shouldEnableLimits,
                    fieldKeypath: \.shouldEnableLimits,
                    title: "Enable"
                )
                .padding(.leading)

                Spacer()
            }
            .padding([.leading, .top])

            SKPSliderWithRelay<SKPhysicsJointSliding, CGFloat, Text, Text>(
                $relay.lowerDistanceLimit,
                fieldKeypath: \.lowerDistanceLimit,
                range: 0...100,
                scalarView: Text(String(format: "%.2f", relay.lowerDistanceLimit)),
                titleView: Text("Lower")
            )

            SKPSliderWithRelay<SKPhysicsJointSliding, CGFloat, Text, Text>(
                $relay.upperDistanceLimit,
                fieldKeypath: \.upperDistanceLimit,
                range: 0...100,
                scalarView: Text(String(format: "%.2f", relay.upperDistanceLimit)),
                titleView: Text("Upper")
            )
        }
    }
}

#Preview {
    PhysicsJointSlidingView(relay: PhysicsJointSlidingRelay())
}
