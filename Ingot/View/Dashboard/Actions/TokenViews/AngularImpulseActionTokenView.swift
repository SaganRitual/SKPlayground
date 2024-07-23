// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct AngularImpulseActionTokenView: View {
    @ObservedObject var token: AngularImpulseActionToken

    let selected: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("Θ-impulse \(String(format: "%.2f", token.torque))")
            Text(String(format: "t = %.2fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
