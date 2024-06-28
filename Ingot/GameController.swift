// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class GameController: ObservableObject {
    weak var commandSelection: CommandSelection!
    weak var entityActionsPublisher: EntityActionsPublisher!
    weak var entitySelectionState: EntitySelectionState!
    weak var gameScene: GameScene!
    weak var physicsBodyState: PhysicsBodyState!
    weak var playgroundState: PlaygroundState!
    weak var spaceActionsState: SpaceActionsState!
    var selectionMarquee: SelectionMarquee!

    var entities = Set<GameEntity>()
    var resumePhysicsSpeed: CGFloat?

    func postInit(
        _ commandSelection: CommandSelection,
        _ entityActionsPublisher: EntityActionsPublisher,
        _ entitySelectionState: EntitySelectionState,
        _ physicsBodyState: PhysicsBodyState,
        _ playgroundState: PlaygroundState,
        _ spaceActionsState: SpaceActionsState
    ) {
        self.commandSelection = commandSelection
        self.entityActionsPublisher = entityActionsPublisher
        self.entitySelectionState = entitySelectionState
        self.physicsBodyState = physicsBodyState
        self.playgroundState = playgroundState
        self.selectionMarquee = SelectionMarquee(playgroundState)
        self.spaceActionsState = spaceActionsState
    }

    func attachPhysicsBody() {
        let body = SKPhysicsBody(circleOfRadius: 25)

        body.affectedByGravity = physicsBodyState.gravitism
        body.allowsRotation = physicsBodyState.rotatism
        body.angularDamping = physicsBodyState.angularDamping
        body.isDynamic = physicsBodyState.dynamism
        body.friction = physicsBodyState.friction
        body.linearDamping = physicsBodyState.linearDamping
        body.mass = physicsBodyState.mass
        body.restitution = physicsBodyState.restitution

        getSelected().first!.avatar!.sceneNode.physicsBody = body
    }

    func loadPhysicsBodyFromSelected() {
        if let body = getSelected().first!.avatar!.sceneNode.physicsBody {
            physicsBodyState.load(body)
        }
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

    func getActionsSpeed() -> CGFloat { gameScene?.speed ?? 1 }
    func setActionsSpeed(_ speed: CGFloat) { gameScene.speed = speed }

    func removePhysicsBody() {
        getSelected().first!.avatar!.sceneNode.physicsBody = nil
    }

    var expectedCompletionReports = 0

    func startActions() {
        entities.forEach { entity in
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
        }

        let selected = getSelected()
        let transaction = SKAction.run { [self, selected] in
            deselectAll()
            
            entities.forEach { entity in
                if entity.actionsArray.isEmpty { return }

                expectedCompletionReports += 1

                let sequence = SKAction.sequence(entity.actionsArray)

                entity.actionsArray.removeAll()

                entity.avatar!.sceneNode.run(sequence) { [self] in
                    entity.position = entity.avatar!.sceneNode.position
                    
                    expectedCompletionReports -= 1

                    if expectedCompletionReports == 0 {
                        let reselect = SKAction.run { [self, selected] in
                            selected.forEach { select($0) }
                        }

                        gameScene.run(reselect)
                    }
                }
            }
        }

        gameScene.run(transaction)
        gameScene.isPaused = false
    }

    func stopActions() { gameScene.isPaused = true }

    func getPhysicsSpeed() -> CGFloat { gameScene?.physicsWorld.speed ?? 0 }
    func setPhysicsSpeed(_ speed: CGFloat) {
        print("speed \(speed)")
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
        print("gravity \(vector)")
        gameScene?.physicsWorld.gravity = vector
    }

    func enableGravityOnSelected(_ enable: Bool) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.affectedByGravity = enable
    }

    func isGravityEnabledOnSelected() -> Bool {
        getSelected().first?.avatar?.sceneNode.physicsBody?.affectedByGravity ?? false
    }

    func enablePhysicsOnSelected(_ enable: Bool) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.isDynamic = false
    }

    func isPhysicsEnabledOnSelected() -> Bool {
        getSelected().first?.avatar?.sceneNode.physicsBody?.isDynamic ?? false
    }

    func enableRotationOnSelected(_ enable: Bool) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.allowsRotation = enable
    }

    func isRotationEnabledOnSelected() -> Bool {
        getSelected().first?.avatar?.sceneNode.physicsBody?.allowsRotation ?? false
    }

    func getDensityOnSelected() -> CGFloat {
        getSelected().first?.avatar?.sceneNode.physicsBody?.density ?? 0
    }

    func setDensityOnSelected(_ density: CGFloat) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.density = density
    }

    func getFrictionOnSelected() -> CGFloat {
        getSelected().first?.avatar?.sceneNode.physicsBody?.friction ?? 0
    }

    func setFrictionOnSelected(_ friction: CGFloat) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.friction = friction
    }

    func getMassOnSelected() -> CGFloat {
        getSelected().first?.avatar?.sceneNode.physicsBody?.mass ?? 0
    }

    func setMassOnSelected(_ mass: CGFloat) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.mass = mass
    }

    func getRestitutionOnSelected() -> CGFloat {
        getSelected().first?.avatar?.sceneNode.physicsBody?.restitution ?? 0
    }

    func setRestitutionOnSelected(_ restitution: CGFloat) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.restitution = restitution
    }
    
    func getAngularDampingOnSelected() -> CGFloat {
        getSelected().first?.avatar?.sceneNode.physicsBody?.angularDamping ?? 0
    }

    func setAngularDampingOnSelected(_ angularDamping: CGFloat) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.angularDamping = angularDamping
    }

    func getLinearDampingOnSelected() -> CGFloat {
        getSelected().first?.avatar?.sceneNode.physicsBody?.linearDamping ?? 0
    }

    func setLinearDampingOnSelected(_ linearDamping: CGFloat) {
        getSelected().first?.avatar?.sceneNode.physicsBody?.linearDamping = linearDamping
    }

    func reloadEntityViews() {
        guard entitySelectionState.selectionState == .one else { return }

        let entity = getSelected().first!

        entityActionsPublisher.actionTokens = entity.getActionTokens()
    }
}
