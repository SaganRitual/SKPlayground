// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class GameController: ObservableObject {
    weak var commandSelection: CommandSelection!
    weak var entityActionsPublisher: EntityActionsPublisher!
    weak var entitySelectionState: EntitySelectionState!
    weak var gameScene: GameScene!
    weak var playgroundState: PlaygroundState!
    weak var spaceActionsState: SpaceActionsState!
    var selectionMarquee: SelectionMarquee!

    var entities = Set<GameEntity>()
    var resumePhysicsSpeed: CGFloat?

    func postInit(
        _ commandSelection: CommandSelection,
        _ entityActionsPublisher: EntityActionsPublisher,
        _ entitySelectionState: EntitySelectionState,
        _ playgroundState: PlaygroundState,
        _ spaceActionsState: SpaceActionsState
    ) {
        self.commandSelection = commandSelection
        self.entityActionsPublisher = entityActionsPublisher
        self.entitySelectionState = entitySelectionState
        self.playgroundState = playgroundState
        self.selectionMarquee = SelectionMarquee(playgroundState)
        self.spaceActionsState = spaceActionsState
    }

    func cancelAssignActionsMode() {
        spaceActionsState.assignSpaceActions = false
        getSelected().first?.cancelActionsMode()
    }

    func commitActions(duration: TimeInterval) {
        spaceActionsState.assignSpaceActions = false

        let entity = getSelected().first!

        entity.commitActions(duration: duration)

        entityActionsPublisher.actionTokens = entity.getActionTokens()
    }

    func installGameScene(_ size: CGSize) -> GameScene {
        let gameScene = GameScene(size)

        self.gameScene = gameScene
        gameScene.postInit(self, self.playgroundState, self.selectionMarquee)

        return gameScene
    }

    func getActionsSpeed() -> CGFloat { gameScene.speed }
    func setActionsSpeed(_ speed: CGFloat) { gameScene.speed = speed }

    func startActions() { gameScene.isPaused = false }
    func stopActions() { gameScene.isPaused = true }

    func getPhysicsSpeed() -> CGFloat { gameScene.physicsWorld.speed }
    func setPhysicsSpeed(_ speed: CGFloat) { gameScene.physicsWorld.speed = speed }

    func startPhysics() {
        setPhysicsSpeed(resumePhysicsSpeed ?? 1)
        resumePhysicsSpeed = nil
    }

    func stopPhysics() {
        if resumePhysicsSpeed == nil {
            resumePhysicsSpeed = getPhysicsSpeed()
            setPhysicsSpeed(0)
        }
    }

    func startActionsMode() {
        spaceActionsState.assignSpaceActions = true
        getSelected().first!.startActionsMode()
    }
}
