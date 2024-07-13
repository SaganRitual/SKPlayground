// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

struct PlaygroundStatusView: View {
    @ObservedObject var gameSceneRelay: GameSceneRelay

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
                Text("\(gameSceneRelay.viewSize)")
            }
            .padding(.bottom)

            HStack {
                Text("Mouse Position")
                Spacer()
                Text(Utility.positionString(gameSceneRelay.mousePosition))
            }
        }
    }
}
