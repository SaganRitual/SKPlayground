// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ImpulseActionTokenView: View {
    let duration: TimeInterval
    let focus: CGPoint
    let impulse: CGVector

    var body: some View {
        VStack(alignment: .center) {
            Text("Impulse \(Utility.vectorString(impulse, 0))")
            Text("At \(Utility.positionString(focus))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle()
    }
}

#Preview {
    ImpulseActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        focus: CGPoint.random(in: -100...100),
        impulse: CGVector.random(in: -100...100)
    )
}
