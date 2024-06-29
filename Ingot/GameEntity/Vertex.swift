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
    static func make(at position: CGPoint) -> Vertex {
        let vertex = Vertex(at: position)
        vertex.face.setOwnerEntity(vertex)
        return vertex
    }

    init(at position: CGPoint) {
        let halo = SelectionHalo()
        let avatar = VertexSprite()
        let face = GameEntityFace(at: position, avatar: avatar, halo: halo)
        super.init(face)
    }
}
