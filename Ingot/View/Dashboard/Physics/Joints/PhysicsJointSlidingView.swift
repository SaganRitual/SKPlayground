// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointSlidingView: View {
    @ObservedObject var relay: PhysicsJointSlidingRelay

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

                GridRow {
                    Text("Distance Limits")
                        .underline()
                        .frame(width: titleWidths.max(), alignment: .leading)
                        .background(
                            GeometryReader { gr in
                                Color.clear.onAppear {
                                    titleWidths.append(gr.size.width)
                                }
                            }
                        )

                    SKPToggle<SKPhysicsJointSliding>(
                        isOn: $relay.shouldEnableLimits,
                        fieldKeypath: \.shouldEnableLimits,
                        title: "Enforce"
                    )
                        .padding(.leading)
                        .frame(width: scalarWidths.max(), alignment: .leading)
                        .background(
                            GeometryReader { gr in
                                Color.clear.onAppear {
                                    scalarWidths.append(gr.size.width)
                                }
                            }
                        )
                }
                .padding(.vertical)

                PhysicsJointSlidingSlidersGridRow<PhysicsJointSlidingRelay, CGFloat, Text, Text>(
                    relay: relay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+100.0", minLabel: "0.0",
                    range: 0...100,
                    scalarView: Text(
                        String(format: "%.2f", relay.lowerDistanceLimit)
                    ),
                    titleView: Text("Lower")
                )

                PhysicsJointSlidingSlidersGridRow<PhysicsJointSlidingRelay, CGFloat, Text, Text>(
                    relay: relay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+100.0", minLabel: "0.0",
                    range: 0...100,
                    scalarView: Text(
                        String(format: "%.2f", relay.upperDistanceLimit)
                    ),
                    titleView: Text("Upper")
                )
            }
        }
    }
}

#Preview {
    PhysicsJointSlidingView(relay: PhysicsJointSlidingRelay())
}
