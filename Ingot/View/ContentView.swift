// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View, CustomDebugStringConvertible {
    var debugDescription: String { "ContentView" }

    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        HStack(alignment: .top) {
            SpriteKitView()
                .frame(minWidth: 1024, minHeight: 768)

            VStack {
                PlaygroundStatusView()
                    .frame(height: 100)
                    .padding()
                    .background(Color(NSColor.secondarySystemFill))
                    .padding(2)

                CommandView()
                    .frame(height: 100)
                    .padding()
                    .background(Color(NSColor.secondarySystemFill))
                    .padding(2)

                ConfigurationTabView()
                    .padding()
                    .background(Color(NSColor.secondarySystemFill))
                    .padding(2)
            }
            .monospaced()
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
