// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

struct PlaygroundStatusView: View, CustomDebugStringConvertible {
    var debugDescription: String { "PlaygroundStatusView" }

    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var playgroundState: PlaygroundState

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("SpriteKit Playground")
                    .underline()
                Spacer()
            }
            .padding(.bottom)

            HStack {
                Text("Scene Size")
                Spacer()
                Text("\(playgroundState.viewSize)")
            }
            .padding(.bottom)

            HStack {
                Text("Mouse Position")
                Spacer()
                Text(Utility.positionString(playgroundState.mousePosition))
            }
        }
        .accessibilityIdentifier(debugDescription)
    }
}
