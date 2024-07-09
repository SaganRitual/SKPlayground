// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsJointSpringView: View {
    @ObservedObject var relay: PhysicsJointSpringRelay

    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

    var body: some View {
        PhysicsJointCommonView(relay: relay)

        Grid {
            PhysicsJointSlidersGridAlignmentRow(
                titleWidths: $titleWidths,
                scalarWidths: $scalarWidths,
                minLabelWidths: $minLabelWidths,
                maxLabelWidths: $maxLabelWidths
            )

            PhysicsJointSpringSlidersGridRow<PhysicsJointSpringRelay, CGFloat, Text, Text>(
                relay: relay,
                titleWidths: $titleWidths,
                scalarWidths: $scalarWidths,
                minLabelWidths: $minLabelWidths,
                maxLabelWidths: $maxLabelWidths,
                maxLabel: "+100.0", minLabel: "0.0",
                range: 0...100,
                scalarView: Text(
                    String(format: "%.2f", relay.damping)
                ),
                titleView: Text("Damping per Oscillation")
            )

            PhysicsJointSpringSlidersGridRow<PhysicsJointSpringRelay, CGFloat, Text, Text>(
                relay: relay,
                titleWidths: $titleWidths,
                scalarWidths: $scalarWidths,
                minLabelWidths: $minLabelWidths,
                maxLabelWidths: $maxLabelWidths,
                maxLabel: "+100.0", minLabel: "0.0",
                range: 0...100,
                scalarView: Text(
                    String(format: "%.2f", relay.frequency)
                ),
                titleView: Text("Oscillation Frequency Hz")
            )
        }
    }
}

#Preview {
    PhysicsJointSpringView(relay: PhysicsJointSpringRelay())
}
