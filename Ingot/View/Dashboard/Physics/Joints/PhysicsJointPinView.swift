// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointPinView: View {
    @ObservedObject var relay: PhysicsJointPinRelay

    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

    var body: some View {
        VStack {
            PhysicsJointCommonView(relay: relay)

            Grid {
                PhysicsJointSlidersGridAlignmentRow(
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths
                )

                PhysicsJointPinSlidersGridRow<PhysicsJointPinRelay, CGFloat, Text, Text>(
                    relay: relay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+10π", minLabel: "-10π",
                    range: (-10 * .pi)...(10 * .pi),
                    scalarView: Text(
                        String(format: "%.2fπ", relay.rotationSpeed / .pi)
                    ),
                    titleView: Text("Rotate (rad/sec)")
                )

                PhysicsJointPinSlidersGridRow<PhysicsJointPinRelay, CGFloat, Text, Text>(
                    relay: relay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+1.0", minLabel: "0.0",
                    range: 0...1,
                    scalarView: Text(
                        String(format: "%.2f", relay.frictionTorque)
                    ),
                    titleView: Text("Friction Torque")
                )

                GridRow {
                    Text("Rotation Angle Limits")
                        .underline()
                        .frame(width: titleWidths.max(), alignment: .leading)
                        .background(
                            GeometryReader { gr in
                                Color.clear.onAppear {
                                    titleWidths.append(gr.size.width)
                                }
                            }
                        )

                    SKPToggle<SKPhysicsJointPin>(
                        isOn: $relay.shouldEnableLimits,
                        fieldKeypath: \.shouldEnableLimits,
                        title: "Enforce"
                    )
                    .padding(.leading)
                    .frame(width: scalarWidths.max(), alignment: .trailing)
                    .background(
                        GeometryReader { gr in
                            Color.clear.onAppear {
                                scalarWidths.append(gr.size.width)
                            }
                        }
                    )
                }
                .padding(.vertical)

                PhysicsJointPinSlidersGridRow<PhysicsJointPinRelay, CGFloat, Text, Text>(
                    relay: relay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+2π", minLabel: "-2π",
                    range: (-2 * .pi)...(2 * .pi),
                    scalarView: Text(
                        String(format: "%.2fπ", relay.lowerAngleLimit / .pi)
                    ),
                    titleView: Text("Lower")
                )

                PhysicsJointPinSlidersGridRow<PhysicsJointPinRelay, CGFloat, Text, Text>(
                    relay: relay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+2π", minLabel: "-2π",
                    range: (-2 * .pi)...(2 * .pi),
                    scalarView: Text(
                        String(format: "%.2fπ", relay.lowerAngleLimit / .pi)
                    ),
                    titleView: Text("Upper")
                )
            }
        }
    }
}

#Preview {
    PhysicsJointPinView(relay: PhysicsJointPinRelay())
}
