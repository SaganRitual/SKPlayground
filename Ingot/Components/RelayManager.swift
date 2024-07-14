// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

final class RelayManager {
    let commandRelay = CommandRelay()
    let gameSceneRelay = GameSceneRelay()
    let physicsBodyRelay = PhysicsBodyRelay()
    let physicsFieldRelay = PhysicsFieldRelay()
    let physicsJointRelay = PhysicsJointRelay()
    let physicsWorldRelay = PhysicsWorldRelay()
    let selectedPhysicsRelay = SelectedPhysicsRelay(.none)
    let workflowRelay = WorkflowRelay()
}

extension RelayManager {

    func activatePhysicsRelay(for entity: GameEntity?) {
        if entity == nil {
            selectedPhysicsRelay.setSelected(.world(physicsWorldRelay))
            return
        }

        if let gremlin = entity as? Gremlin {
            physicsBodyRelay.loadState(from: gremlin)
            selectedPhysicsRelay.setSelected(.body(physicsBodyRelay))
            return
        }

        if let field = entity as? Field {
            physicsFieldRelay.loadState(from: field)
            selectedPhysicsRelay.setSelected(.field(physicsFieldRelay))
            return
        }

        if let joint = entity as? Joint {
            physicsJointRelay.loadState(from: joint)

            if joint.physicsJoint is SKPhysicsJointFixed {
                let relay = Utility.forceCast(physicsJointRelay, to: PhysicsJointFixedRelay.self)
                selectedPhysicsRelay.setSelected(.jointFixed(relay))
                return
            }

            if joint.physicsJoint is SKPhysicsJointLimit {
                let relay = Utility.forceCast(physicsJointRelay, to: PhysicsJointLimitRelay.self)
                selectedPhysicsRelay.setSelected(.jointLimit(relay))
                return
            }

            if joint.physicsJoint is SKPhysicsJointPin {
                let relay = Utility.forceCast(physicsJointRelay, to: PhysicsJointPinRelay.self)
                selectedPhysicsRelay.setSelected(.jointPin(relay))
                return
            }

            if joint.physicsJoint is SKPhysicsJointSliding {
                let relay = Utility.forceCast(physicsJointRelay, to: PhysicsJointSlidingRelay.self)
                selectedPhysicsRelay.setSelected(.jointSliding(relay))
                return
            }

            if joint.physicsJoint is SKPhysicsJointSpring {
                let relay = Utility.forceCast(physicsJointRelay, to: PhysicsJointSpringRelay.self)
                selectedPhysicsRelay.setSelected(.jointSpring(relay))
                return
            }

            fatalError("We thought this couldn't happen")
        }
    }

    func subscribeToRelays(entityManager: EntityManager, sceneManager: SKPScene) {
        physicsBodyRelay.subscribe(entityManager: entityManager)
        physicsFieldRelay.subscribe(entityManager: entityManager)
        physicsJointRelay.subscribe(entityManager: entityManager)
        physicsWorldRelay.subscribe(sceneManager: sceneManager)
    }
}
