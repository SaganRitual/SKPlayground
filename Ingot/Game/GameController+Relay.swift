// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

extension GameController {

//    func updateSelectedPhysicsBody<T: AnyObject, Value>(
//        whichField: WritableKeyPath<T, Value>, newValue: Value
//    ) {
//        guard entitySelectionState.selectionState == .one else { return }
//        guard let entity = getSelected().first, var physicsBody = entity.physicsBody else { return }
//        physicsBody[keyPath: whichField] = newValue
//    }

    func updateSelectedRelayTarget<T: AnyObject, U>(whichField: ReferenceWritableKeyPath<T, U>, newValue: U) {
        guard entitySelectionState.selectionState == .one else { return }

        if let gremlin = getSelected().first,
           let physicsBody = gremlin.physicsBody,
           let keyPath = whichField as? ReferenceWritableKeyPath<SKPhysicsBody, U>
        {
            physicsBody[keyPath: keyPath] = newValue
            return
        }

        if let field = getSelected().first,
           let physicsField = field.face.rootSceneNode.children.first(where: { $0 is SKFieldNode }) as? SKFieldNode,
           let keyPath = whichField as? ReferenceWritableKeyPath<SKFieldNode, U>
        {
            physicsField[keyPath: keyPath] = newValue
            return
        }
    }

}
