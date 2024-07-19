// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsActionSlidersGridRow<TitleView: View, ScalarView: View>: View {
    @Binding var titleWidths: [CGFloat]
    @Binding var scalarWidths: [CGFloat]
    @Binding var minLabelWidths: [CGFloat]
    @Binding var maxLabelWidths: [CGFloat]

    @Binding var scalar: CGFloat

    let maxLabel: String
    let minLabel: String
    let range: ClosedRange<CGFloat>
    let scalarView: ScalarView
    let titleView: TitleView

    var body: some View {
        GridRow {
            titleView
                .fixedSize()
                .frame(width: titleWidths.max(), alignment: .leading)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            titleWidths.append(gr.size.width)
                        }
                    }
                )

            scalarView
                .fixedSize()
                .frame(width: scalarWidths.max(), alignment: .trailing)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            scalarWidths.append(gr.size.width)
                        }
                    }
                )

            Text(minLabel)
                .fixedSize()
                .frame(width: minLabelWidths.max(), alignment: .trailing)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            minLabelWidths.append(gr.size.width)
                        }
                    }
                )

            Slider(value: $scalar, in: range)

            Text(maxLabel)
                .fixedSize()
                .frame(width: maxLabelWidths.max(), alignment: .trailing)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            maxLabelWidths.append(gr.size.width)
                        }
                    }
                )
        }
    }
}

struct PhysicsActionSlidersGrid: View {
    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

    @Binding var selectedAction: ActionToken?

    var body: some View {
        Grid {
            GridRow {
                Text("Apply at X")
                    .fixedSize()
                    .hidden()
                    .underline()
                    .frame(width: titleWidths.max(), alignment: .leading)
                    .background(
                        GeometryReader { gr in
                            Color.clear.onAppear {
                                titleWidths.append(gr.size.width)
                            }
                        }
                    )

                Text("+000.00π")
                    .fixedSize()
                    .hidden()
                    .frame(width: scalarWidths.max(), alignment: .trailing)
                    .background(
                        GeometryReader { gr in
                            Color.clear.onAppear {
                                scalarWidths.append(gr.size.width)
                            }
                        }
                    )

                Text("+000.00π")
                    .fixedSize()
                    .hidden()
                    .frame(width: minLabelWidths.max(), alignment: .trailing)
                    .background(
                        GeometryReader { gr in
                            Color.clear.onAppear {
                                minLabelWidths.append(gr.size.width)
                            }
                        }
                    )
            }
            .padding(.top)

            if var forceIsh = self.selectedAction as? ForceIshActionToken {
                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { forceIsh.forceDX },
                            set: { forceIsh.forceDX = $0 }
                        ),
                        maxLabel: "+10.0",
                        minLabel: "-10.0",
                        range: (-10.0)...(+10.0),
                        scalarView: Text(
                            String(format: "%.2f", forceIsh.forceDX)
                        ),
                        titleView: Text("Vector  dX")
                    )
                }

                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { forceIsh.forceDY },
                            set: { forceIsh.forceDY = $0 }
                        ),
                        maxLabel: "+10.0",
                        minLabel: "-10.0",
                        range: (-10.0)...(+10.0),
                        scalarView: Text(
                            String(format: "%.2f", forceIsh.forceDY)
                        ),
                        titleView: Text("        dY")
                    )
                }

                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { forceIsh.positionX },
                            set: { forceIsh.positionX = $0 }
                        ),
                        maxLabel: "+1.0",
                        minLabel: "-1.0",
                        range: (-1.0)...(+1.0),
                        scalarView: Text(
                            String(format: "%.2f", forceIsh.positionX)
                        ),
                        titleView: Text("Apply at X")
                    )
                }

                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { forceIsh.positionY },
                            set: { forceIsh.positionY = $0 }
                        ),
                        maxLabel: "+1.0",
                        minLabel: "-1.0",
                        range: (-1.0)...(+1.0),
                        scalarView: Text(
                            String(format: "%.2f", forceIsh.positionY)
                        ),
                        titleView: Text("         Y")
                    )
                }
            } else if var torqueIsh = selectedAction as? TorqueIshActionToken {
                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { torqueIsh.torque },
                            set: { torqueIsh.torque = $0 }
                        ),
                        maxLabel: "+2π",
                        minLabel: "-2π",
                        range: (-2 * .pi)...(+2 * .pi),
                        scalarView: Text(
                            String(format: "%.2fπ/s", torqueIsh.torque)
                        ),
                        titleView: Text("Torque")
                    )
                }
            }

            if let selectedAction {
                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { CGFloat(selectedAction.duration) },
                            set: { selectedAction.duration = TimeInterval($0) }
                        ),
                        maxLabel: "+5.0",
                        minLabel: "0.01",
                        range: (0.01)...(+5.0),
                        scalarView: Text(
                            String(format: "%.2f", selectedAction.duration)
                        ),
                        titleView: Text("Duration")
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    PhysicsBodySlidersGrid(physicsBodyRelay: PhysicsBodyRelay())
}
