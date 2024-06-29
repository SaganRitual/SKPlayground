// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class GremlinFace: GameEntityFace {
    var rsHalo: SelectionHaloRS {
        halo as! SelectionHaloRS
    }

    override var rotation: CGFloat {
        get { rootSceneNode.zRotation }
        set { rootSceneNode.zRotation = newValue }
    }

    override var scale: CGFloat {
        get { rootSceneNode.xScale }
        set {
            rootSceneNode.xScale = newValue
            rootSceneNode.yScale = newValue

            halo?.setScale(newValue)
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
