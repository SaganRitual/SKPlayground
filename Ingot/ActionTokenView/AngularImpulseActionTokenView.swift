// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AngularImpulseActionTokenView: View {
    let duration: TimeInterval
    let angularImpulse: CGFloat

    var body: some View {
        VStack(alignment: .center) {
            Text("Θ-impulse \(String(format: "%.1f", angularImpulse))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle()
    }
}

#Preview {
    AngularImpulseActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        angularImpulse: .random(in: -10.0...10.0)
    )
}
