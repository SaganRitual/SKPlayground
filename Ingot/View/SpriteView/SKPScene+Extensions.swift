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

    func startActions() {

    }

    func startActionsOnSelected() {
        
    }

    func stopActions() {

    }

    func startPhysics() {

    }

    func stopPhysics() {
        
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
