// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

extension GameController {
    func activateActionsRelay(for entity: GameEntity) {
        selectedAction = entity.selectedAction

        if selectedAction != nil {
            actionRelay.loadState(from: entity)
        }
    }

    func activatePhysicsBodyRelay(for entity: GameEntity) {
        selectedPhysicsBody = entity.physicsBody

        physicsBodyRelay.loadState(from: entity)
    }

    func activatePhysicsFieldRelay(for entity: GameEntity) {
        selectedPhysicsField = entity.selectedPhysicsField

        if selectedPhysicsField != nil {
            physicsFieldRelay.loadState(from: entity)
        }
    }

    func activatePhysicsJointRelay(for entity: GameEntity) {
        selectedPhysicsJoint = entity.selectedPhysicsJoint

        if selectedPhysicsJoint != nil {
            physicsJointRelay.loadState(from: entity)
        }
    }

    func activateRelays(for entity: GameEntity) {
        activateActionsRelay(for: entity)
        activatePhysicsBodyRelay(for: entity)
        activatePhysicsFieldRelay(for: entity)
        activatePhysicsJointRelay(for: entity)
    }

    func deactivateRelays() {
        selectedAction = nil
    }

    func initializeRelays() {
        selectedAction = nil
    }

    func subscribeToRelays(sceneManager: SKPScene) {
        physicsBodyRelay.subscribe(gameController: self)
        physicsFieldRelay.subscribe(gameController: self)
        physicsJointRelay.subscribe(gameController: self)
        physicsWorldRelay.subscribe(sceneManager: sceneManager)
    }

    func updateRelaysForSelection() {
        let selected = getSelected()
        if selected.count == 1 {
            let entity = Utility.forceUnwrap(selected.first)
            activateRelays(for: entity)
        } else {
            deactivateRelays()
        }
    }
}
