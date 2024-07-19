// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ForceActionTokenView: View {
    let selected: Bool
    let token: ForceActionToken

    init(_ token: ForceActionToken, selected: Bool) {
        self.token = token
        self.selected = selected
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Force \(Utility.vectorString(token.force, 0))")
            Text("At \(Utility.positionString(token.focus))")
            Text(String(format: "t = %.1fs", token.duration))
        }
        .actionTokenStyle(selected)
    }
}
