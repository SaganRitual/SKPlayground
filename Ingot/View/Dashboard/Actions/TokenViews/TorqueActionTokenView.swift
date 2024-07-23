// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct TorqueActionTokenView: View {
    @ObservedObject var token: TorqueActionToken

    let selected: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("Torque \(String(format: "%.2f", token.torque))")
            Text(String(format: "t = %.1fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
