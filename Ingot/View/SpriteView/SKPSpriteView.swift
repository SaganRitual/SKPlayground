// We are a way for the cosmos to know itself. -- C. Sagan

import AppKit
import Foundation
import SpriteKit
import SwiftUI

struct SKPSpriteView: NSViewRepresentable {
    let scene: SKPScene

    func makeNSView(context: Context) -> SKView {
        let view = SKPView()

        view.showsFPS = true
        view.showsDrawCount = true
        view.showsNodeCount = true
        view.showsQuadCount = true

        view.presentScene(scene)
        return view
    }

    func updateNSView(_ view: SKView, context: Context) { }
}
