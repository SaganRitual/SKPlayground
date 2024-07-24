// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

final class SKPPhysicsBody: ObservableObject {
    let body: SKPhysicsBody

    init(_ body: SKPhysicsBody) {
        self.body = body
    }
}

final class SKPPhysicsWorld: ObservableObject {
    let world: SKPhysicsWorld

    init(world: SKPhysicsWorld) {
        self.world = world
    }
}

final class GameController: ObservableObject {
    @Published var actionRelay = ActionRelay()
    @Published var commandRelay = CommandRelay()
    @Published var gameSceneRelay = GameSceneRelay()
    @Published var physicsBodyRelay = PhysicsBodyRelay()
    @Published var physicsFieldRelay = PhysicsFieldRelay()
    @Published var physicsJointRelay = PhysicsJointRelay()
    @Published var physicsWorldRelay = PhysicsWorldRelay()
    @Published var workflowRelay = WorkflowRelay()

    @Published var selectedEntity: GameEntity?

    @Published var selectedAction: ActionToken?
    @Published var selectedPhysicsBody: SKPPhysicsBody?
    @Published var selectedPhysicsField: SKPPhysicsField?
    @Published var selectedPhysicsJoint: SKPPhysicsJoint?

    static let sceneMinimumSize = CGSize(width: 1024, height: 1024)

    let contextMenuManager = ContextMenuManager()
    let gestureEventDispatcher = GestureEventDispatcher()
    let inputEventDispatcher = InputEventDispatcher()
    let physicsMaskNamesManager = PhysicsMaskNamesManager()
    let sceneManager = SKPScene(size: GameController.sceneMinimumSize)
    let selectionMarquee = SelectionMarquee()
    let workflowManager = WorkflowManager()

    var entities = Set<GameEntity>()

    weak var hotDragTarget: GameEntity?
    var hotDragSubhandle: SelectionHaloRS.Directions?

    func singleSelected() -> GameEntity? {
        let selected = getSelected()
        if selected.count == 1 {
            return selected.first
        } else {
            return nil
        }
    }

    func postInit() {
        contextMenuManager.gameController = self
        contextMenuManager.gestureEventDispatcher = gestureEventDispatcher
        contextMenuManager.workflowManager = workflowManager

        gestureEventDispatcher.contextMenuManager = contextMenuManager
        gestureEventDispatcher.gameController = self
        gestureEventDispatcher.selectionMarquee = selectionMarquee
        gestureEventDispatcher.workflowManager = workflowManager

        inputEventDispatcher.gestureDelegate = gestureEventDispatcher

        sceneManager.gameSceneRelay = gameSceneRelay
        sceneManager.inputDelegate = inputEventDispatcher
        sceneManager.physicsWorldRelay = physicsWorldRelay

        sceneManager.addChild(selectionMarquee.marqueeRootNode)

        subscribeToRelays(sceneManager: sceneManager)

        workflowManager.workflowRelay = workflowRelay

        initializeRelays()
    }
}

extension GameController {
    enum ActionSet: String, CaseIterable, Identifiable, RawRepresentable {
        var id: Self { self }
        case all, physics, space
    }

    func isInSet(_ token: ActionToken, _ set: ActionSet) -> Bool {
        switch set {
        case .all:     return true
        case .physics: return token.isPhysicsAction
        case .space:   return token.isSpaceAction
        }
    }

    func startActions(_ set: ActionSet) {
        entities.compactMap({ $0 as? Gremlin }).forEach { gremlin in
            let actions = gremlin.actions.filter({ isInSet($0, set) }).map { actionToken in
                actionToken.makeSKAction()
            }

            gremlin.face.rootSceneNode.run(SKAction.sequence(actions))
        }
    }

    func startActionsOnSelected(_ set: ActionSet) {
        getSelected().compactMap({ $0 as? Gremlin }).forEach { gremlin in
            let actions = gremlin.actions.filter({ isInSet($0, set) }).map { actionToken in
                actionToken.makeSKAction()
            }

            gremlin.face.rootSceneNode.run(SKAction.sequence(actions))
        }
    }
}
