// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AngularImpulseActionTokenView: View {
    let selected: Bool
    let token: AngularImpulseActionToken

    init(_ token: AngularImpulseActionToken, selected: Bool) {
        self.selected = selected
        self.token = token
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Θ-impulse \(String(format: "%.1f", token.torque))")
            Text(String(format: "t = %.1fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
