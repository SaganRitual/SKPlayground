// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointPinView: View {
    @ObservedObject var relay: PhysicsJointPinRelay

    var body: some View {
        VStack {
            PhysicsJointCommonView(relay: relay)

            SKPSliderWithRelay<SKPhysicsJointPin, CGFloat, Text, Text>(
                $relay.rotationSpeed,
                fieldKeypath: \.rotationSpeed,
                minLabel: "-10π", maxLabel: "+10π",
                range: (-10 * .pi)...(10 * .pi),
                scalarView: Text(String(format: "%.2fπ rad/sec", relay.rotationSpeed / .pi)),
                titleView: Text("Rotate")
            )

            SKPSliderWithRelay<SKPhysicsJointPin, CGFloat, Text, Text>(
                $relay.frictionTorque,
                fieldKeypath: \.frictionTorque,
                range: 0...1,
                scalarView: Text(String(format: "%.2f", relay.frictionTorque)),
                titleView: Text("Friction Torque")
            )

            HStack {
                Text("Rotation Angle Limits")
                    .underline()

                SKPToggle<SKPhysicsJointPin>(
                    isOn: $relay.shouldEnableLimits,
                    fieldKeypath: \.shouldEnableLimits,
                    title: "Enable"
                )
            }

            SKPSliderWithRelay<SKPhysicsJointPin, CGFloat, Text, Text>(
                $relay.lowerAngleLimit,
                fieldKeypath: \.lowerAngleLimit,
                range: (-2 * .pi)...(2 * .pi),
                scalarView: Text(String(format: "%.2fπ", relay.lowerAngleLimit / .pi)),
                titleView: Text("Lower")
            )

            SKPSliderWithRelay<SKPhysicsJointPin, CGFloat, Text, Text>(
                $relay.upperAngleLimit,
                fieldKeypath: \.upperAngleLimit,
                range: (-2 * .pi)...(2 * .pi),
                scalarView: Text(String(format: "%.2fπ", relay.upperAngleLimit / .pi)),
                titleView: Text("Upper")
            )
        }
    }
}
