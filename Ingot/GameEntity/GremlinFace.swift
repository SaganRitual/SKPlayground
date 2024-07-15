// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class GremlinFace: GameEntityFace {
    var rsHalo: SelectionHaloRS { Utility.forceCast(halo, to: SelectionHaloRS.self) }

    override var rotation: CGFloat {
        get { rootSceneNode.zRotation }
        set { rootSceneNode.zRotation = newValue }
    }

    override var scale: CGFloat {
        get { rootSceneNode.xScale }
        set {
            let s = max(1, newValue)
            rootSceneNode.setScale(s)
            rsHalo.setScale(s)  // This is so the halo can downsize the subhandles
        }
    }

    init(at position: CGPoint, avatarName: String) {
        let halo = SelectionHaloRS.make()
        let avatar = GremlinSprite(avatarName)
        super.init(at: position, avatar: avatar, halo: halo)
    }

    override func setOwnerEntity(_ entity: GameEntity) {
        super.setOwnerEntity(entity)

        rsHalo.subhandles.values.forEach { sh in
            sh.sceneNode.setOwnerEntity(entity)
        }
    }
}
