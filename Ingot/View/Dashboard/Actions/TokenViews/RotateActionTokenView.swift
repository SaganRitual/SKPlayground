// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct RotateActionTokenView: View, ActionTokenViewProtocol {
    let duration: Double
    let targetRotation: CGFloat
    let selected: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("Rotate to \(String(format: "%.2f", targetRotation))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle(selected)
    }
}

#Preview {
    RotateActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        targetRotation: CGFloat.random(in: (-2 * .pi)...(2 * .pi)),
        selected: false
    )
}
