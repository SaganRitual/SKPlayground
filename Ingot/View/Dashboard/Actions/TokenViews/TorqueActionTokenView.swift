// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct TorqueActionTokenView: View {
    let selected: Bool
    let token: TorqueActionToken

    init(_ token: TorqueActionToken, selected: Bool) {
        self.selected = selected
        self.token = token
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Torque \(String(format: "%.1f", token.torque))")
            Text(String(format: "t = %.1fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
