// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsWorldSlidersGridRow<RelayObject: AnyObject, TargetField, TitleView: View, ScalarView: View>: View
    where TargetField: Comparable & AdditiveArithmetic & ExpressibleByIntegerLiteral & BinaryFloatingPoint,
    TargetField.Stride: BinaryFloatingPoint
{
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    @Binding var titleWidths: [CGFloat]
    @Binding var scalarWidths: [CGFloat]
    @Binding var minLabelWidths: [CGFloat]
    @Binding var maxLabelWidths: [CGFloat]

    @Binding var scalar: CGFloat

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
                value: $scalar,
                in: CGFloat(range.lowerBound)...CGFloat(range.upperBound)
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

struct PhysicsWorldSlidersGrid: View {
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

    @State private var gravityX = CGFloat.zero
    @State private var gravityY = CGFloat.zero

    var body: some View {
        Grid {
            GridRow {
                Text("")
                    .fixedSize()
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
            .frame(height: 0)

            GridRow {
                PhysicsWorldSlidersGridRow<PhysicsWorldRelay, CGFloat, Text, Text>(
                    physicsWorldRelay: physicsWorldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    scalar: $gravityX,
                    maxLabel: "+25.0",
                    minLabel: "-25.0",
                    range: (-25.0)...(+25.0),
                    scalarView: Text(
                        String(format: "%.2f", gravityX)
                    ),
                    titleView: Text("Gravity X")
                )
                .onChange(of: gravityX) { _, newValue in
                    physicsWorldRelay.gravity.dx = newValue
                }
            }

            GridRow {
                PhysicsWorldSlidersGridRow<PhysicsWorldRelay, CGFloat, Text, Text>(
                    physicsWorldRelay: physicsWorldRelay,
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    scalar: $gravityY,
                    maxLabel: "+25.0",
                    minLabel: "-25.0",
                    range: (-25.0)...(+25.0),
                    scalarView: Text(
                        String(format: "%.2f", gravityY)
                    ),
                    titleView: Text("Gravity Y")
                )
                .onChange(of: gravityY) { _, newValue in
                    physicsWorldRelay.gravity.dy  = newValue
                }
            }
        }
        .padding()
    }
}

#Preview {
    PhysicsWorldSlidersGrid(physicsWorldRelay: PhysicsWorldRelay())
        .environmentObject(SelectedPhysicsRelay(.body(PhysicsBodyRelay())))
}
