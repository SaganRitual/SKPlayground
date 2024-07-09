// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsBodySlidersGridRow<RelayObject: AnyObject, TargetField, TitleView: View, ScalarView: View>: View
    where TargetField: Comparable & AdditiveArithmetic & ExpressibleByIntegerLiteral & BinaryFloatingPoint,
    TargetField.Stride: BinaryFloatingPoint
{
    @ObservedObject var physicsBodyRelay: PhysicsBodyRelay

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
                value: $physicsBodyRelay.charge,
                in: CGFloat(range.lowerBound)...CGFloat(range.upperBound)
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

struct PhysicsBodySlidersGrid: View {
    @ObservedObject var physicsBodyRelay: PhysicsBodyRelay

    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

    var body: some View {
        Grid {
            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+2.0",
                    minLabel: "-2.0",
                    range: (-2.0)...(+2.0),
                    scalarView: Text(
                        String(format: "%.2f", physicsBodyRelay.charge)
                    ),
                    titleView: Text("Charge")
                )
            }

            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+25.0",
                    minLabel: "-2.0",
                    range: (-2.0)...(+25.0),
                    scalarView: Text(
                        String(format: "%.2f", physicsBodyRelay.friction)
                    ),
                    titleView: Text("Friction")
                )
            }

            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+10.0",
                    minLabel: " 0.0",
                    range: 0...10,
                    scalarView: Text(
                        String(format: "%.2f", physicsBodyRelay.mass)
                    ),
                    titleView: Text("Mass")
                )
            }

            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+2.0",
                    minLabel: "-2.0",
                    range: (-2.0)...(+2.0),
                    scalarView: Text(
                        String(format: "%.2f", physicsBodyRelay.restitution)
                    ),
                    titleView: Text("Restitution")
                )
            }

            GridRow {
                Text("Damping")
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
            .padding(.top)

            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+2.0",
                    minLabel: "-2.0",
                    range: (-2.0)...(+2.0),
                    scalarView: Text(
                        String(format: "%.2f", physicsBodyRelay.angularDamping)
                    ),
                    titleView: Text("Angular")
                )
                .padding(.top)
            }

            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    maxLabel: "+2.0",
                    minLabel: "-2.0",
                    range: (-2.0)...(+2.0),
                    scalarView: Text(
                        String(format: "%.2f", physicsBodyRelay.linearDamping)
                    ),
                    titleView: Text("Linear")
                )
            }
        }
        .padding()
//        HStack {
//            PhysicsBodySliderTitles(physicsBodyRelay: physicsBodyRelay)
//            PhysicsBodySliderValues(physicsBodyRelay: physicsBodyRelay)
//            PhysicsBodyMinLabels(physicsBodyRelay: physicsBodyRelay)
//            PhysicsBodySliders(physicsBodyRelay: physicsBodyRelay)
//            PhysicsBodyMaxLabels(physicsBodyRelay: physicsBodyRelay)
//        }
    }
}

#Preview {
    PhysicsBodySlidersGrid(physicsBodyRelay: PhysicsBodyRelay())
}
