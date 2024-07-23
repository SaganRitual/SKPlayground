// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ImpulseActionTokenView: View {
    @ObservedObject var token: ImpulseActionToken

    let selected: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("Impulse \(Utility.vectorString(token.force, 2))")
            Text("At \(Utility.positionString(token.focus, 2))")
            Text(String(format: "t = %.2fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
