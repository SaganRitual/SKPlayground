// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            SpriteKitView()

            VStack(spacing: -2) {
                CommandView()
                    .border(.black, width: 2)

                PhysicsTabView()
                    .border(.black, width: 2)

                ActionsTabView()
                    .border(.black, width: 2)

                ActionTokensScrollView()
                    .frame(maxWidth: .infinity)
                    .border(.black, width: 2)
            }
            .monospaced()
        }
    }
}

#Preview {
    @StateObject var ps = PlaygroundState()
    ps.makeTestTokensArray()

    return ContentView()
        .environmentObject(GameController())
        .environmentObject(ps)
}
