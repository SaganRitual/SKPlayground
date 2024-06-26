// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class VertexSprite: GameEntitySprite {
    init() {
        let image = Image(systemName: "mappin.and.ellipse.circle.fill").font(.title)

        // Thanks Oskar!
        // https://stackoverflow.com/a/69315037/1610473
        let renderedByOskar = image.renderAsImage()!

        let texture = SKTexture(image: renderedByOskar)
        let sprite = SKSpriteNode(texture: texture)

        sprite.color = .cyan
        sprite.colorBlendFactor = 1

        super.init(sceneNode: sprite)
    }
}

final class Vertex: GameEntity {
    private let halo_: SelectionHalo
    override var halo: SelectionHalo? { halo_ }

    private let avatar_: GameEntitySprite
    override var avatar: GameEntitySprite? { avatar_ }

    init(halo halo_: SelectionHalo, avatar avatar_: GameEntitySprite) {
        self.halo_ = halo_
        self.avatar_ = avatar_
    }

    static func make(at position: CGPoint) -> Vertex {
        let halo = SelectionHalo()
        let avatar = VertexSprite()
        let vertex = Vertex(halo: halo, avatar: avatar)

        halo.sceneNode.setOwnerEntity(vertex)
        avatar.sceneNode.setOwnerEntity(vertex)

        vertex.position = position

        return vertex
    }
}
