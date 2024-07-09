// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsFieldSlidersGridRow<RelayObject: AnyObject, TargetField, TitleView: View, ScalarView: View>: View
    where TargetField: Comparable & AdditiveArithmetic & ExpressibleByIntegerLiteral & BinaryFloatingPoint,
    TargetField.Stride: BinaryFloatingPoint
{
    @ObservedObject var physicsFieldRelay: PhysicsFieldRelay

    @Binding var titleWidths: [CGFloat]
    @Binding var scalarWidths: [CGFloat]
    @Binding var minLabelWidths: [CGFloat]
    @Binding var maxLabelWidths: [CGFloat]

    let maxLabel: String
    let minLabel: String
    let range: ClosedRange<TargetField>
    let scalarView: ScalarView
    let titleView: TitleView

    var body: some View {
        GridRow {
            titleView
                .frame(width: titleWidths.max(), alignment: .leading)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            titleWidths.append(gr.size.width)
                        }
                    }
                )

            scalarView
                .frame(width: scalarWidths.max(), alignment: .trailing)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            scalarWidths.append(gr.size.width)
                        }
                    }
                )

            Text(minLabel)
                .frame(width: minLabelWidths.max(), alignment: .trailing)
                .background(
                    GeometryReader { gr in
                        Color.clear.onAppear {
                            minLabelWidths.append(gr.size.width)
                        }
                    }
                )

            Slider(
                value: $physicsFieldRelay.animationSpeed,
                in: Float(range.lowerBound)...Float(range.upperBound)
            )

            Text(maxLabel)
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

struct PhysicsFieldSlidersGrid: View {
    @ObservedObject var physicsFieldRelay: PhysicsFieldRelay

    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

    var body: some View {
        Grid {
            GridRow {
                Text("")
                    .hidden()
                    .frame(width: titleWidths.max(), alignment: .leading)
                    .background(
                        GeometryReader { gr in
                            Color.clear.onAppear {
                                titleWidths.append(gr.size.width)
                            }
                        }
                    )

                Text("+000.00π")
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
            .frame(height: 0)

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, CGFloat, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+10.0",
                    minLabel: "0.0",
                    range: 0...10,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.animationSpeed)
                    ),
                    titleView: Text("Animation Speed")
                )
            }

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, CGFloat, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+10.0",
                    minLabel: "0.0",
                    range: 0...10,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.falloff)
                    ),
                    titleView: Text("Falloff")
                )
            }

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, CGFloat, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+100.0",
                    minLabel: " 0.0",
                    range: 0...100,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.minimumRadius)
                    ),
                    titleView: Text("Minimum Radius")
                )
            }

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, CGFloat, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+10.0",
                    minLabel: "0.0",
                    range: 0...10,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.smoothness)
                    ),
                    titleView: Text("Smoothness")
                )
            }

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, CGFloat, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+100.0",
                    minLabel: " 0.0",
                    range: 0...100,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.strength)
                    ),
                    titleView: Text("Strength")
                )
            }
        }
        .padding()
    }
}

#Preview {
    PhysicsFieldSlidersGrid(physicsFieldRelay: PhysicsFieldRelay())
}
