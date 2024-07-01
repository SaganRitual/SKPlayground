// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class GameController: ObservableObject {
    weak var commandSelection: CommandSelection!
    weak var entityActionsPublisher: EntityActionsPublisher!
    weak var entitySelectionState: EntitySelectionState!
    weak var gameScene: GameScene!
    weak var physicsBodyState: PhysicsBodyState!
    weak var physicsFieldState: PhysicsFieldState!
    weak var playgroundState: PlaygroundState!
    weak var spaceActionsState: SpaceActionsState!
    var selectionMarquee: SelectionMarquee!

    var entities = Set<GameEntity>()
    var resumePhysicsSpeed: CGFloat?
    var selectionOrderTracker = 0
    let spriteManager = SpriteManager()

    func postInit(
        _ commandSelection: CommandSelection,
        _ entityActionsPublisher: EntityActionsPublisher,
        _ entitySelectionState: EntitySelectionState,
        _ physicsBodyState: PhysicsBodyState,
        _ physicsFieldState: PhysicsFieldState,
        _ playgroundState: PlaygroundState,
        _ spaceActionsState: SpaceActionsState
    ) {
        self.commandSelection = commandSelection
        self.entityActionsPublisher = entityActionsPublisher
        self.entitySelectionState = entitySelectionState
        self.physicsBodyState = physicsBodyState
        self.physicsFieldState = physicsFieldState
        self.playgroundState = playgroundState
        self.selectionMarquee = SelectionMarquee(playgroundState)
        self.spaceActionsState = spaceActionsState
    }

    func loadPhysicsBodyFromSelected() {
        if let body = getSelected().first?.physicsBody {
            physicsBodyState.load(body)
        }
    }

    func cancelAssignActionsMode() {
        spaceActionsState.assignSpaceActions = false
        getSelected().first?.cancelActionsMode()
    }

    func commitSpaceActions(duration: TimeInterval) {
        spaceActionsState.assignSpaceActions = false

        let entity = getSelected().first!

        entity.commitSpaceActions(duration: duration)

        entityActionsPublisher.actionTokens = entity.getActionTokens()
    }

    func commitPhysicsAction(_ actionToken: ActionTokenProtocol) {
        let entity = getSelected().first!

        entity.commitPhysicsAction(actionToken)

        entityActionsPublisher.actionTokens = entity.getActionTokens()
    }

    func installGameScene(_ size: CGSize) -> GameScene {
        let gameScene = GameScene(size)

        self.gameScene = gameScene
        gameScene.postInit(self, self.playgroundState, self.selectionMarquee)

        return gameScene
    }

    func getActionsSpeed() -> CGFloat { gameScene?.speed ?? 1 }
    func setActionsSpeed(_ speed: CGFloat) { gameScene.speed = speed }

    func removePhysicsBody() {
        getSelected().first!.physicsBody = nil
    }

    var expectedCompletionReports = 0

    func startActions(_ targetEntities: Set<GameEntity>) {
        targetEntities.forEach { entity in
            let containers = entity.getActionTokens()

            entity.actionsArray = containers.map { tokenContainer in
                switch tokenContainer.token {
                case let move as MoveActionToken:
                    return SKAction.move(to: move.targetPosition, duration: move.duration)
                case let rotate as RotateActionToken:
                    return SKAction.rotate(toAngle: rotate.targetRotation, duration: rotate.duration)
                case let scale as ScaleActionToken:
                    return SKAction.scale(to: scale.targetScale, duration: scale.duration)
                case let force as ForceActionToken:
                    return SKAction.applyForce(force.force, at: force.focus, duration: force.duration)
                case let impulse as ImpulseActionToken:
                    return SKAction.applyImpulse(impulse.impulse, at: impulse.focus, duration: impulse.duration)
                case let torque as TorqueActionToken:
                    return SKAction.applyTorque(torque.torque, duration: torque.duration)
                case let angularImpulse as AngularImpulseActionToken:
                    return SKAction.applyAngularImpulse(angularImpulse.angularImpulse, duration: angularImpulse.duration)
                default:
                    fatalError("Numerous reputable accordion players insist that this can't happen")
                }
            }

            entity.face.rootSceneNode.run(SKAction.sequence(entity.actionsArray))
        }

        gameScene.isPaused = false
    }

    func startActions() {
        startActions(entities)
    }

    func startActionsOnSelected() {
        startActions(getSelected())
    }

    func stopActions() {
        gameScene.removeAllActions()

        entities.forEach { entity in
            entity.face.rootSceneNode.removeAllActions()
        }
    }

    func getPhysicsSpeed() -> CGFloat { gameScene?.physicsWorld.speed ?? 1 }
    func setPhysicsSpeed(_ speed: CGFloat) {
        gameScene?.physicsWorld.speed = speed

        if resumePhysicsSpeed != nil {
            resumePhysicsSpeed = speed
        }
    }

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

    func getGravity() -> CGVector {
        gameScene?.physicsWorld.gravity ?? .zero
    }

    func setGravity(_ vector: CGVector) {
        gameScene?.physicsWorld.gravity = vector
    }

    func enableGravityOnSelected(_ enable: Bool) {
        getSelected().first?.physicsBody?.affectedByGravity = enable
    }

    func isGravityEnabledOnSelected() -> Bool {
        getSelected().first?.physicsBody?.affectedByGravity ?? false
    }

    func enablePhysicsOnSelected(_ enable: Bool) {
        getSelected().first?.physicsBody?.isDynamic = enable
    }

    func isPhysicsEnabledOnSelected() -> Bool {
        getSelected().first?.physicsBody?.isDynamic ?? false
    }

    func enableRotationOnSelected(_ enable: Bool) {
        getSelected().first?.physicsBody?.allowsRotation = enable
    }

    func isRotationEnabledOnSelected() -> Bool {
        getSelected().first?.physicsBody?.allowsRotation ?? false
    }

    func getDensityOnSelected() -> CGFloat {
        getSelected().first?.physicsBody?.density ?? 0
    }

    func setDensityOnSelected(_ density: CGFloat) {
        getSelected().first?.physicsBody?.density = density
    }

    func getFrictionOnSelected() -> CGFloat {
        getSelected().first?.physicsBody?.friction ?? 0
    }

    func setFrictionOnSelected(_ friction: CGFloat) {
        getSelected().first?.physicsBody?.friction = friction
    }

    func getMassOnSelected() -> CGFloat {
        getSelected().first?.physicsBody?.mass ?? 0
    }

    func setMassOnSelected(_ mass: CGFloat) {
        getSelected().first?.physicsBody?.mass = mass
    }

    func getRestitutionOnSelected() -> CGFloat {
        getSelected().first?.physicsBody?.restitution ?? 0
    }

    func setRestitutionOnSelected(_ restitution: CGFloat) {
        getSelected().first?.physicsBody?.restitution = restitution
    }
    
    func getAngularDampingOnSelected() -> CGFloat {
        getSelected().first?.physicsBody?.angularDamping ?? 0
    }

    func setAngularDampingOnSelected(_ angularDamping: CGFloat) {
        getSelected().first?.physicsBody?.angularDamping = angularDamping
    }

    func getLinearDampingOnSelected() -> CGFloat {
        getSelected().first?.physicsBody?.linearDamping ?? 0
    }

    func setLinearDampingOnSelected(_ linearDamping: CGFloat) {
        getSelected().first?.physicsBody?.linearDamping = linearDamping
    }

    func reloadEntityViews() {
        guard entitySelectionState.selectionState == .one else { return }

        let entity = getSelected().first!

        entityActionsPublisher.actionTokens = entity.getActionTokens()
    }

    func enableSceneEdgeLoop(_ enable: Bool) {
        gameScene?.enableEdgeLoop = enable
    }

    func getSceneEdgeLoopEnabled() -> Bool {
        gameScene?.enableEdgeLoop ?? false
    }
}
