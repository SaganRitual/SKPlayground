// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct SKPSliderWithRelay<RelayObject: AnyObject, Field, TitleView: View, ScalarView: View>: View
    where Field: Comparable & AdditiveArithmetic & ExpressibleByIntegerLiteral & BinaryFloatingPoint,
    Field.Stride: BinaryFloatingPoint
{
    @EnvironmentObject var gameController: GameController

    @Binding var scalar: Field

    let fieldKeypath: ReferenceWritableKeyPath<RelayObject, Field>
    let maxLabel: String?
    let minLabel: String?
    let range: ClosedRange<Field>
    let scalarView: ScalarView
    let titleView: TitleView
    let widthScalar: Double
    let widthSlider: Double
    let widthTitle: Double

    init(
        _ scalar: Binding<Field>,
        fieldKeypath: ReferenceWritableKeyPath<RelayObject, Field>,
        minLabel: String? = nil,
        maxLabel: String? = nil,
        range: ClosedRange<Field>,
        scalarView: ScalarView,
        titleView: TitleView,
        widthScalar: Double = 35,
        widthSlider: Double = 140,
        widthTitle: Double = 95
    ) {
        self._scalar = scalar
        self.fieldKeypath = fieldKeypath
        self.maxLabel = maxLabel
        self.minLabel = minLabel
        self.range = range
        self.scalarView = scalarView
        self.titleView = titleView
        self.widthScalar = widthScalar
        self.widthSlider = widthSlider
        self.widthTitle = widthTitle
    }

    var body: some View {
        SKPSlider(
            $scalar,
            maxLabel: maxLabel, minLabel: minLabel,
            range: range, scalarView: scalarView, titleView: titleView
        )
        .onChange(of: scalar) { _, newValue in
            gameController.updateSelectedRelayTarget(whichField: fieldKeypath, newValue: newValue)
        }
    }
}

#Preview {
    @State var scalar: Float = 0

    return SKPSliderWithRelay<SKFieldNode, Float, Text, Text>(
        $scalar,
        fieldKeypath: \.strength,
        range: 0...10,
        scalarView: Text(String(format: "%.2f", scalar)),
        titleView: Text("Strength")
    )
    .monospaced()
}
