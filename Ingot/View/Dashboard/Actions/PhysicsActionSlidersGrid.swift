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

    @ObservedObject var actionRelay: ActionRelay
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

            if self.selectedAction is ForceIshActionToken {
                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { actionRelay.forceDX },
                            set: { actionRelay.forceDX = $0 }
                        ),
                        maxLabel: "+10.0",
                        minLabel: "-10.0",
                        range: (-10.0)...(+10.0),
                        scalarView: Text(
                            String(format: "%.2f", actionRelay.forceDX)
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
                            get: { actionRelay.forceDY },
                            set: { actionRelay.forceDY = $0 }
                        ),
                        maxLabel: "+10.0",
                        minLabel: "-10.0",
                        range: (-10.0)...(+10.0),
                        scalarView: Text(
                            String(format: "%.2f", actionRelay.forceDY)
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
                            get: { actionRelay.positionX },
                            set: { actionRelay.positionX = $0 }
                        ),
                        maxLabel: "+1.0",
                        minLabel: "-1.0",
                        range: (-1.0)...(+1.0),
                        scalarView: Text(
                            String(format: "%.2f", actionRelay.positionX)
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
                            get: { actionRelay.positionY },
                            set: { actionRelay.positionY = $0 }
                        ),
                        maxLabel: "+1.0",
                        minLabel: "-1.0",
                        range: (-1.0)...(+1.0),
                        scalarView: Text(
                            String(format: "%.2f", actionRelay.positionY)
                        ),
                        titleView: Text("         Y")
                    )
                }
            } else if selectedAction is TorqueIshActionToken {
                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { actionRelay.torque },
                            set: { actionRelay.torque = $0 }
                        ),
                        maxLabel: "+2π",
                        minLabel: "-2π",
                        range: (-2 * .pi)...(+2 * .pi),
                        scalarView: Text(
                            String(format: "%.2fπ/s", actionRelay.torque)
                        ),
                        titleView: Text("Torque")
                    )
                }
            }

            if selectedAction != nil {
                GridRow {
                    PhysicsActionSlidersGridRow<Text, Text>(
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        scalar: Binding(
                            get: { CGFloat(actionRelay.duration) },
                            set: { actionRelay.duration = TimeInterval($0) }
                        ),
                        maxLabel: "+5.0",
                        minLabel: "0.01",
                        range: (0.01)...(+5.0),
                        scalarView: Text(
                            String(format: "%.2f", actionRelay.duration)
                        ),
                        titleView: Text("Duration")
                    )
                }
            }
        }
        .padding()
    }
}
