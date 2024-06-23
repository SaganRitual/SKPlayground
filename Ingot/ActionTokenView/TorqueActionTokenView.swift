// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct TorqueActionTokenView: View {
    let duration: TimeInterval
    let torque: CGFloat

    var body: some View {
        VStack(alignment: .center) {
            Text("Torque \(String(format: "%.1f", torque))")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle()
    }
}

#Preview {
    TorqueActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        torque: .random(in: -10.0...10.0)
    )
}
