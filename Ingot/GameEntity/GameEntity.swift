// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GameEntity {
    let uuid = UUID()

    var actionsArray = [SKAction]()

    let face: GameEntityFace

    var dragging = false

    var dragAnchor: CGPoint?
    var rotationAnchor: CGFloat?
    var scaleAnchor: CGFloat?

    var physicsBody: SKPhysicsBody? { get { nil } set { } }

    var position: CGPoint {
        get { face.position }
        set { face.position = newValue }
    }

    var rotation: CGFloat { get { 0 } set { } }

    var scale: CGFloat { get { 1 } set { } }

    init(_ face: GameEntityFace) {
        self.face = face
    }

    func addActionToken(_ token: any ActionTokenProtocol) { }
    func getActionTokens() -> [ActionTokenContainer] { [] }

    func restoreActionAnchors() { }

    func setAssignActionsMode(_ setIt: Bool) {
        face.halo?.setSelectionMode(setIt ? .assignActions : .normal)
    }

    func cancelActionsMode() { }
    func commitPhysicsAction(_ token: ActionTokenProtocol) { }
    func commitSpaceActions(duration: TimeInterval) { }
    func startActionsMode() { }
}

extension GameEntity {
    var isSelected: Bool { face.isSelected }
    func deselect() { face.deselect() }
    func select() { face.select() }
    func toggleSelect() { face.toggleSelect() }
}

extension GameEntity: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        return lhs === rhs
    }
}
