// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    @StateObject var ps = PlaygroundState()
    @StateObject var gc = GameController()

    var body: some View {
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
        .environmentObject(gc)
        .environmentObject(ps)
        .onAppear {
            gc.postInit(ps)
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
