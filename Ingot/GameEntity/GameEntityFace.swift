// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GameEntityFace {
    let rootSceneNode: SKNode

    let avatar: GameEntitySprite?
    let halo: SelectionHalo?

    var dragging = false

    var dragAnchor: CGPoint?
    var rotationAnchor: CGFloat?
    var scaleAnchor: CGFloat?

    var position: CGPoint {
        get { rootSceneNode.position }
        set { rootSceneNode.position = newValue }
    }

    // swiftlint:disable unused_setter_value
    var rotation: CGFloat { get { 0 } set { } }
    var scale: CGFloat { get { 1 } set { } }
    // swiftlint:enable unused_setter_value

    init(at position: CGPoint, avatar: GameEntitySprite, halo: SelectionHalo) {
        self.avatar = avatar
        self.halo = halo
        self.rootSceneNode = SKNode()
        self.position = position

        rootSceneNode.addChild(avatar.sceneNode)
        rootSceneNode.addChild(halo.sceneNode)
    }

    func setOwnerEntity(_ entity: GameEntity) {
        rootSceneNode.setOwnerEntity(entity)    // Not necessary yet, but I don't know, tidiniess or something
        halo?.sceneNode.setOwnerEntity(entity)
        avatar?.sceneNode.setOwnerEntity(entity)
    }
}

extension GameEntityFace {
    var isSelected: Bool { halo!.isSelected }
    func deselect() { halo!.deselect() }
    func select() { halo!.select() }
    func toggleSelect() { halo!.toggleSelect() }
}
