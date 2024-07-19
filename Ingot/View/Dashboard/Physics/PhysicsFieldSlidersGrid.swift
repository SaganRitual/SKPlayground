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

    let fieldKeyPath: ReferenceWritableKeyPath<PhysicsFieldRelay, TargetField>
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
                value: Binding(
                    get: { Float(physicsFieldRelay[keyPath: fieldKeyPath]) },
                    set: { physicsFieldRelay[keyPath: fieldKeyPath] = TargetField($0) }
                ),
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

    @State private var gravityX = Float.zero
    @State private var gravityY = Float.zero

    func getLabelsAndRange<T: BinaryFloatingPoint>() -> (max: String, min: String, range: ClosedRange<T>) {
        switch physicsFieldRelay.fieldType {
        case .vortex:
            return ("+0.5", "-0.5", -0.5...0.5)
        default:
            return ("+10.0", "-10.0", -10.0...10.0)
        }
    }

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

            if physicsFieldRelay.fieldType == .noise || physicsFieldRelay.fieldType == .turbulence {
                GridRow {
                    PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                        physicsFieldRelay: physicsFieldRelay,
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        fieldKeyPath: \.animationSpeed,
                        maxLabel: "+10.0",
                        minLabel: "0.0",
                        range: 0...10,
                        scalarView: Text(
                            String(format: "%.2f", physicsFieldRelay.animationSpeed)
                        ),
                        titleView: Text("Animation Speed")
                    )
                }
            }

            if physicsFieldRelay.fieldType == .linearGravity {
                GridRow {
                    PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                        physicsFieldRelay: physicsFieldRelay,
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        fieldKeyPath: \.gravityX,
                        maxLabel: "+10.0",
                        minLabel: "-10.0",
                        range: (-10.0)...(+10.0),
                        scalarView: Text(
                            String(format: "%.2f", gravityX)
                        ),
                        titleView: Text("Gravity X")
                    )
                }

                GridRow {
                    PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                        physicsFieldRelay: physicsFieldRelay,
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        fieldKeyPath: \.gravityY,
                        maxLabel: "+10.0",
                        minLabel: "-10.0",
                        range: (-10.0)...(+10.0),
                        scalarView: Text(
                            String(format: "%.2f", gravityY)
                        ),
                        titleView: Text("Gravity Y")
                    )
                }
            }

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    fieldKeyPath: \.falloff,
                    maxLabel: "+3.0",
                    minLabel: "0.0",
                    range: 0...3,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.falloff)
                    ),
                    titleView: Text("Falloff")
                )
            }

            GridRow {
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    fieldKeyPath: \.minimumRadius,
                    maxLabel: "+512.0",
                    minLabel: " 0.0",
                    range: 0...512,
                    scalarView: Text(
                        String(format: "%.2f", physicsFieldRelay.minimumRadius)
                    ),
                    titleView: Text("Minimum Radius")
                )
            }

            if physicsFieldRelay.fieldType == .noise {
                GridRow {
                    PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                        physicsFieldRelay: physicsFieldRelay,
                        titleWidths: $titleWidths,
                        scalarWidths: $scalarWidths,
                        minLabelWidths: $minLabelWidths,
                        maxLabelWidths: $maxLabelWidths,
                        fieldKeyPath: \.smoothness,
                        maxLabel: "+10.0",
                        minLabel: "0.0",
                        range: 0...10,
                        scalarView: Text(
                            String(format: "%.2f", physicsFieldRelay.smoothness)
                        ),
                        titleView: Text("Smoothness")
                    )
                }
            }

            GridRow {
                let (max, min, range): (String, String, ClosedRange<Float>) = getLabelsAndRange()
                PhysicsFieldSlidersGridRow<PhysicsFieldRelay, Float, Text, Text>(
                    physicsFieldRelay: physicsFieldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    fieldKeyPath: \.strength,
                    maxLabel: max,
                    minLabel: min,
                    range: range,
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
