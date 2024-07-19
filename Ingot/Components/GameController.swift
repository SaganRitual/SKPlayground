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

final class SKPPhysicsField: ObservableObject {
    let field: SKFieldNode

    init(field: SKFieldNode) {
        self.field = field
    }
}

final class SKPPhysicsJoint: ObservableObject {
    let joint: SKPhysicsJoint

    init(joint: SKPhysicsJoint) {
        self.joint = joint
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
    func commitMarqueeSelect(_ entities: Set<GameEntity>, _ shiftKey: Bool) {
        if shiftKey {
            entities.forEach { toggleSelect($0) }
        } else {
            deselectAll()
            entities.forEach { select($0) }
        }
    }

    func deselect(_ entity: GameEntity) {
        entity.deselect()
        updateRelaysForSelection()
    }

    func deselectAll() {
        getSelected().forEach { deselect($0) }
    }

    func getSelected() -> Set<GameEntity> {
        Set(entities.compactMap({ $0.isSelected ? $0 : nil }))
    }

    func select(_ entity: GameEntity) {
        entity.select()
        updateRelaysForSelection()
    }

    func toggleSelect(_ entity: GameEntity) {
        if entity.isSelected {
            deselect(entity)
        } else {
            select(entity)
        }
    }
}
