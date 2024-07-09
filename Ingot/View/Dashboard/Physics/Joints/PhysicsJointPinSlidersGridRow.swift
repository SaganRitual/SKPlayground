// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsJointPinSlidersGridRow<
    RelayObject: AnyObject,
    TargetField,
    TitleView: View,
    ScalarView: View
>: View
    where
    TargetField:
        Comparable &
        AdditiveArithmetic &
        ExpressibleByIntegerLiteral &
        BinaryFloatingPoint,
    TargetField.Stride:
        BinaryFloatingPoint
{
    @ObservedObject var relay: PhysicsJointPinRelay

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
                value: $relay.rotationSpeed,
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
