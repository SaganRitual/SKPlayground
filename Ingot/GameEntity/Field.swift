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
    private let halo_: SelectionHalo
    override var halo: SelectionHalo? { halo_ }

    private let avatar_: GameEntitySprite
    override var avatar: GameEntitySprite? { avatar_ }

    init(halo halo_: SelectionHalo, avatar avatar_: GameEntitySprite) {
        self.halo_ = halo_
        self.avatar_ = avatar_
    }

    static func make(at position: CGPoint) -> Field {
        let halo = SelectionHalo()
        let avatar = FieldSprite()
        let field = Field(halo: halo, avatar: avatar)

        halo.sceneNode.setOwnerEntity(field)
        avatar.sceneNode.setOwnerEntity(field)

        field.position = position

        return field
    }
}
