// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct BasicScalarSlider<TitleView: View, ScalarView: View>: View {
    @Binding var scalar: CGFloat

    let scalarView: ScalarView
    let title: TitleView
    let minLabel: String
    let maxLabel: String
    let range: ClosedRange<CGFloat>

    var body: some View {
        HStack {
            title
                .frame(width: 65, alignment: .leading)

            scalarView
                .frame(width: 35, alignment: .leading)

            HStack {
                Text(minLabel)
                Slider(value: $scalar, in: range)
                Text(maxLabel)
            }
            .frame(width: 140, alignment: .leading)
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
