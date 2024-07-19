// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ScaleActionTokenView: View, ActionTokenViewProtocol {
    let duration: Double
    let targetScale: CGFloat
    let selected: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("Scale to \(String(format: "%.2fx", targetScale))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle(selected)
    }
}

#Preview {
    ScaleActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        targetScale: CGFloat.random(in: 1...10),
        selected: false
    )
}
