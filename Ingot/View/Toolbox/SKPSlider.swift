// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct SKPSlider<TargetField, TitleView: View, ScalarView: View>: View
    where TargetField: Comparable & AdditiveArithmetic & ExpressibleByIntegerLiteral & BinaryFloatingPoint,
          TargetField.Stride: BinaryFloatingPoint
{
    @Binding var scalar: TargetField

    let maxLabel: String
    let minLabel: String
    let range: ClosedRange<TargetField>
    let scalarView: ScalarView
    let titleView: TitleView
    let widthScalar: Double
    let widthSlider: Double?
    let widthTitle: Double

    init(
        _ scalar: Binding<TargetField>,
        maxLabel: String? = nil,
        minLabel: String? = nil,
        range: ClosedRange<TargetField>,
        scalarView: ScalarView,
        titleView: TitleView,
        widthScalar: Double = 35,
        widthSlider: Double? = nil,
        widthTitle: Double = 95
    ) {
        self._scalar = scalar
        self.range = range
        self.scalarView = scalarView
        self.titleView = titleView
        self.widthScalar = widthScalar
        self.widthSlider = widthSlider
        self.widthTitle = widthTitle

        self.maxLabel = maxLabel ?? "\(range.upperBound)"
        self.minLabel = minLabel ?? "\(range.lowerBound)"
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            titleView
                .frame(width: widthTitle, alignment: .leading)

            scalarView
                .frame(width: widthScalar, alignment: .leading)

            HStack {
                Text(minLabel)
                Slider(value: $scalar, in: range)
                Text(maxLabel)
            }
            .frame(
                minWidth: widthSlider ?? 0,
                maxWidth: widthSlider == nil ? .infinity : 0,
                alignment: .leading
            )
            .padding([.horizontal])
        }
        .padding()
    }
}

#Preview {
    @State var scalar: CGFloat = 0

    return SKPSlider(
        $scalar,
        range: 0.1...5.0,
        scalarView: Text(String(format: "%.2f", scalar)),
        titleView: Text("Duration")
    )
    .monospaced()
}
