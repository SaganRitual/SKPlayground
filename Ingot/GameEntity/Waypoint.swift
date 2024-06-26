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
    private let halo_: SelectionHalo
    override var halo: SelectionHalo? { halo_ }

    private let avatar_: GameEntitySprite
    override var avatar: GameEntitySprite? { avatar_ }

    init(halo halo_: SelectionHalo, avatar avatar_: GameEntitySprite) {
        self.halo_ = halo_
        self.avatar_ = avatar_
    }

    static func make(at position: CGPoint) -> Waypoint {
        let halo = SelectionHalo()
        let avatar = WaypointSprite()
        let waypoint = Waypoint(halo: halo, avatar: avatar)

        halo.sceneNode.setOwnerEntity(waypoint)
        avatar.sceneNode.setOwnerEntity(waypoint)

        waypoint.position = position

        return waypoint
    }
}
