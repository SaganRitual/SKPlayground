// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension SKPScene {
    func addEntity(_ entity: GameEntity) {
        entitiesNode.addChild(entity.face.rootSceneNode)
    }

    func enableEdgeLoop(_ enable: Bool) {
        self.physicsBody = enable ? edgeLoop : nil
    }

    func isEdgeLoopEnabled() -> Bool {
        self.physicsBody != nil
    }

    func retrieveEscapedGremlins() {
        entitiesNode.children.compactMap({ node in node.ownerIsGremlin() }).forEach { gremlin in
            let hw = size.width / 2
            let hh = size.height / 2

            let origin = CGPoint(x: -hw, y: -hh)

            if !CGRect(origin: origin, size: self.size).contains(gremlin.position) {
                gremlin.position = CGPoint.random(in: (-hw)...(+hw), yRange: (-hh)...(+hh))
            }
        }
    }

    func startActions() {

    }

    func startActionsOnSelected() {
        
    }

    func stopActions() {

    }

    func pausePhysics() {
        physicsRunSpeed = physicsWorldRelay.speed
        physicsWorldRelay.speed = 0
    }

    func playPhysics() {
        if physicsRunSpeed == 0 {
            physicsRunSpeed = 1
        }

        physicsWorldRelay.speed = physicsRunSpeed
    }

    func getNodesInRectangle(_ rectangle: CGRect) -> [SKNode] {
        return entitiesNode.children.compactMap { node in
            guard rectangle.contains(node.position) else {
                return nil
            }

            if node.getOwnerEntity() == nil {
                return nil
            }

            return node
        }
    }
}
