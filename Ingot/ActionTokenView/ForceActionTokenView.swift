// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ForceActionTokenView: View {
    let duration: TimeInterval
    let focus: CGPoint
    let force: CGVector

    var body: some View {
        VStack(alignment: .center) {
            Text("Force \(Utility.vectorString(force, 0))")
            Text("At \(Utility.positionString(focus))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle()
    }
}

#Preview {
    ForceActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        focus: CGPoint.random(in: -100...100),
        force: CGVector.random(in: -100...100)
    )
}
