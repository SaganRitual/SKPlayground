// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SwiftUI

struct PlaygroundStatusView: View {
    @ObservedObject var gameSceneRelay: GameSceneRelay

    private var mousePositionPublisher: AnyPublisher<CGPoint, Never> {
        gameSceneRelay.$mousePosition
            .debounce(for: .seconds(0.005), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    @State private var mousePosition: CGPoint = .zero // Local state to store the debounced value

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
                Text(Utility.positionString(mousePosition))
            }
        }
        .onReceive(mousePositionPublisher) { self.mousePosition = $0 }
    }
}
