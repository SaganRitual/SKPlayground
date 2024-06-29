// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct BasicScalarSlider<TitleView: View, ScalarView: View>: View {
    @Binding var scalar: CGFloat

    let scalarView: ScalarView
    let title: TitleView
    let minLabel: String
    let maxLabel: String
    let range: ClosedRange<CGFloat>
    let widthScalar: CGFloat
    let widthSlider: CGFloat
    let widthTitle: CGFloat

    init(
        scalar: Binding<CGFloat>,
        scalarView: ScalarView,
        title: TitleView,
        minLabel: String,
        maxLabel: String,
        range: ClosedRange<CGFloat>,
        widthScalar: CGFloat = 35,
        widthSlider: CGFloat = 140,
        widthTitle: CGFloat = 95
    ) {
        self._scalar = scalar
        self.scalarView = scalarView
        self.title = title
        self.minLabel = minLabel
        self.maxLabel = maxLabel
        self.range = range
        self.widthScalar = widthScalar
        self.widthSlider = widthSlider
        self.widthTitle = widthTitle
    }

    var body: some View {
        HStack {
            title
                .frame(width: widthTitle, alignment: .leading)

            scalarView
                .frame(width: widthScalar, alignment: .leading)

            HStack {
                Text(minLabel)
                Slider(value: $scalar, in: range)
                Text(maxLabel)
            }
            .frame(width: widthSlider, alignment: .leading)
            .padding([.horizontal])
        }
        .padding(.vertical)
    }
}

#Preview {
    @State var scalar: CGFloat = 0

    return BasicScalarSlider(
        scalar: $scalar,
        scalarView: Text(String(format: "%.1f", scalar)),
        title: Text("Duration"),
        minLabel: "0.1", maxLabel: "5.0",
        range: 0.1...5.0
    )
}
