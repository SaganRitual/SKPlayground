// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PlaySlidersGridRow<TargetField, TitleView: View, ScalarView: View>: View
    where TargetField: Comparable & AdditiveArithmetic & ExpressibleByIntegerLiteral & BinaryFloatingPoint,
    TargetField.Stride: BinaryFloatingPoint
{
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

struct PlaySlidersGrid: View {
    @ObservedObject var commandRelay: CommandRelay
    @ObservedObject var physicsWorldRelay: PhysicsWorldRelay

    @State private var titleWidths = [CGFloat]()
    @State private var scalarWidths = [CGFloat]()
    @State private var minLabelWidths = [CGFloat]()
    @State private var maxLabelWidths = [CGFloat]()

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
                PlaySlidersGridRow<CGFloat, Text, Text>(
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    scalar: Binding(
                        get: { commandRelay.actionsSpeed },
                        set: { commandRelay.actionsSpeed = $0 }
                    ),
                    maxLabel: "10", minLabel: "0", range: 0...10,
                    scalarView: Text(String(format: "%.1f", commandRelay.actionsSpeed)),
                    titleView: Text("Actions Speed")
                )
            }

            GridRow {
                PlaySlidersGridRow<CGFloat, Text, Text>(
                    titleWidths: $titleWidths,
                    scalarWidths: $scalarWidths,
                    minLabelWidths: $minLabelWidths,
                    maxLabelWidths: $maxLabelWidths,
                    scalar: Binding(
                        get: { physicsWorldRelay.speed },
                        set: { physicsWorldRelay.speed = $0 }
                    ),
                    maxLabel: "10", minLabel: "0", range: 0...10,
                    scalarView: Text(String(format: "%.1f", physicsWorldRelay.speed)),
                    titleView: Text("Physics Speed")
                )
            }
        }
        .padding()
     }
}
