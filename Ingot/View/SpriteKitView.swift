// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit
import SwiftUI

struct SpriteKitView: NSViewRepresentable {
    @EnvironmentObject var gameController: GameController

    func makeNSView(context: Context) -> SKView {
        let view = SKView()

        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        view.preferredFramesPerSecond = 60
        view.shouldCullNonVisibleNodes = false
        view.isAsynchronous = false
        view.showsPhysics = true
        view.showsFields = true
        view.showsDrawCount = true
        view.showsQuadCount = true
        view.isAsynchronous = true
        view.allowsTransparency = true

        let gameScene = gameController.installGameScene(view.bounds.size)

        view.presentScene(gameScene)

        Task { @MainActor in
            view.window?.makeFirstResponder(view)
        }

        return view
    }

    func updateNSView(_ nsView: SKView, context: Context) { }
}
