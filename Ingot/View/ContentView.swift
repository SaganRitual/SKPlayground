// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .top) {
            SpriteKitView()
                .frame(minWidth: 1024, minHeight: 768)

            DashboardView()
        }
        .background(Color(NSColor.tertiarySystemFill))
    }
}

#Preview {
    @StateObject var ps = PlaygroundState()
    ps.makeTestTokensArray()

    return ContentView()
        .environmentObject(GameController())
        .environmentObject(ps)
}
