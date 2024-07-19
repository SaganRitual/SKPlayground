// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ImpulseActionTokenView: View {
    let selected: Bool
    let token: ImpulseActionToken

    init(_ token: ImpulseActionToken, selected: Bool) {
        self.selected = selected
        self.token = token
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Impulse \(Utility.vectorString(token.force, 0))")
            Text("At \(Utility.positionString(token.focus))")
            Text(String(format: "t = %.1fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
