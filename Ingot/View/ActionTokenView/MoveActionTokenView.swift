// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct MoveActionTokenView: View, ActionTokenViewProtocol {
    let duration: Double
    let targetPosition: CGPoint

    var body: some View {
        VStack(alignment: .center) {
            Text("Move to \(Utility.positionString(targetPosition, 0))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle()
    }
}

#Preview {
    MoveActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        targetPosition: CGPoint(x: .random(in: -100...100), y: .random(in: -100...100))
    )
}
