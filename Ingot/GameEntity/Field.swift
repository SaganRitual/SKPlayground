// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class FieldSprite: GameEntitySprite {
    init() {
        let image = Image(systemName: "laser.burst").font(.title)

        // Thanks Oskar!
        // https://stackoverflow.com/a/69315037/1610473
        let renderedByOskar = image.renderAsImage()!

        let texture = SKTexture(image: renderedByOskar)
        let sprite = SKSpriteNode(texture: texture)

        sprite.color = .yellow
        sprite.colorBlendFactor = 1

        super.init(sceneNode: sprite)
    }
}

final class Field: GameEntity {
    static func make(at position: CGPoint) -> Field {
        let field = Field(at: position)
        field.face.setOwnerEntity(field)
        return field
    }

    init(at position: CGPoint) {
        let halo = SelectionHalo()
        let avatar = FieldSprite()
        let face = GameEntityFace(at: position, avatar: avatar, halo: halo)
        super.init(face)
    }
}
