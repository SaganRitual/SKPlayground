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

    var selectionOrder = 0

    init(_ face: GameEntityFace) {
        self.face = face
    }

    func addActionToken(_ token: any ActionTokenProtocol) { }
    func getActionTokens() -> [ActionTokenContainer] { [] }

    func restoreActionAnchors() { }

    func cancelActionsMode() { }
    func commitFollowPathAction(_ token: ActionTokenProtocol) { }
    func commitPhysicsAction(_ token: ActionTokenProtocol) { }
    func commitSpaceActions(duration: TimeInterval) { }
    func startActionsMode() { }
}

extension GameEntity {

    func resetSelectionMode() {
        face.halo?.setSelectionMode(.normal)
    }

    func setAssignActionsMode() {
        face.halo?.setSelectionMode(.assignActions)
    }

    func setOrderIndicator(_ oi: SelectionHalo.OrderIndicator) {
        face.halo?.setSelectionMode(.orderIndicator(oi))
    }
}

extension GameEntity {
    var isSelected: Bool { face.isSelected }
    func deselect() { face.deselect() }
    func select(_ selectionOrder: Int) { self.selectionOrder = selectionOrder; face.select() }
    func toggleSelect(_ selectionOrder: Int) { self.selectionOrder = selectionOrder; face.toggleSelect() }
}

extension GameEntity: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        return lhs === rhs
    }
}
