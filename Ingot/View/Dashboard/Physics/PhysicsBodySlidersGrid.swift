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

    let fieldKeyPath: ReferenceWritableKeyPath<PhysicsBodyRelay, TargetField>  // Add keypath property
    let maxLabel: String
    let minLabel: String
    let range: ClosedRange<TargetField>
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

            Slider(
                value: Binding(
                    get: { physicsBodyRelay[keyPath: fieldKeyPath] },
                    set: { physicsBodyRelay[keyPath: fieldKeyPath] = $0 }
                ),
                in: TargetField(CGFloat(range.lowerBound))...TargetField(CGFloat(range.upperBound))
            )

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
                    fieldKeyPath: \.charge,
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
                    fieldKeyPath: \.friction,
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
                    fieldKeyPath: \.mass,
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
                    fieldKeyPath: \.restitution,
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
                    .fixedSize()
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

            GridRow {
                PhysicsBodySlidersGridRow<PhysicsBodyRelay, CGFloat, Text, Text>(
                    physicsBodyRelay: physicsBodyRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    fieldKeyPath: \.angularDamping,
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
                    fieldKeyPath: \.linearDamping,
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
    }
}

#Preview {
    PhysicsBodySlidersGrid(physicsBodyRelay: PhysicsBodyRelay())
}
