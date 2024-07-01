// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class SpriteManager {
    var availableSprites = Set<SKSpriteNode>()
    var inUseSprites = Set<SKSpriteNode>()

    func getLineSprite() -> SKSpriteNode {
        if let sprite = availableSprites.first {
            availableSprites.remove(sprite)
            inUseSprites.insert(sprite)
            return sprite
        }

        let sprite = SKSpriteNode(imageNamed: "pixel_1x1")
        inUseSprites.insert(sprite)
        return sprite
    }

    func releaseAll() {
        let stableCopy = inUseSprites.map { $0 }
        stableCopy.forEach { releaseSprite($0) }
    }

    func releaseSprite(_ sprite: SKSpriteNode) {
        inUseSprites.remove(sprite)
        availableSprites.insert(sprite)
        sprite.removeFromParent()
    }
}
