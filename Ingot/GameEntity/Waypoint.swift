// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class WaypointSprite: GameEntitySprite {
    init() {
        let image = Image(systemName: "figure.run").font(.title)

        // Thanks Oskar!
        // https://stackoverflow.com/a/69315037/1610473
        let renderedByOskar = image.renderAsImage()!

        let texture = SKTexture(image: renderedByOskar)
        let sprite = SKSpriteNode(texture: texture)

        sprite.color = .green
        sprite.colorBlendFactor = 1

        super.init(sceneNode: sprite)
    }
}

final class Waypoint: GameEntity {
    static func make(at position: CGPoint) -> Waypoint {
        let waypoint = Waypoint(at: position)
        waypoint.face.setOwnerEntity(waypoint)
        return waypoint
    }

    init(at position: CGPoint) {
        let halo = SelectionHalo()
        let avatar = WaypointSprite()
        let face = GameEntityFace(at: position, avatar: avatar, halo: halo)
        super.init(face)
    }
}
