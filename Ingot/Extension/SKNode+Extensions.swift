// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension SKNode {
    func ownerIsGremlin() -> Gremlin? {
        return getOwnerEntity() as? Gremlin
    }

    func getOwnerEntity() -> GameEntity? {
        guard let entry = userData?["ownerEntity"] else { return nil }
        return entry as? GameEntity
    }

    func setOwnerEntity(_ entity: GameEntity) {
        if userData == nil { userData = [:] }
        userData!["ownerEntity"] = entity
    }

    func hide() { isHidden = true }
    func show() { isHidden = false }
    func toggleVisible() { isHidden = !isHidden }

    var gameScene: SKPScene { Utility.forceCast(scene, to: SKPScene.self) }
}
