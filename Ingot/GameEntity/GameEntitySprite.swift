// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class GameEntitySprite {
    let sceneNode: SKNode

    init(sceneNode: SKNode) {
        self.sceneNode = sceneNode
    }
}

class GremlinSprite: GameEntitySprite {
    init(_ name: String) {
        let sceneNode = SKSpriteNode(imageNamed: name)
        super.init(sceneNode: sceneNode)
    }
}

// MARK: Stuff to help us use SF Symbols as sprites

class NoInsetHostingView<V>: NSHostingView<V> where V: View {
    override var safeAreaInsets: NSEdgeInsets {
        return .init()
    }
}

extension View {
    func renderAsImage() -> NSImage? {
        let view = NoInsetHostingView(rootView: self)
        view.setFrameSize(view.fittingSize)
        return view.bitmapImage()
    }
}

public extension NSView {
    func bitmapImage() -> NSImage? {
        guard let rep = bitmapImageRepForCachingDisplay(in: bounds) else {
            return nil
        }

        cacheDisplay(in: bounds, to: rep)

        guard let cgImage = rep.cgImage else {
            return nil
        }

        return NSImage(cgImage: cgImage, size: bounds.size)
    }
}
