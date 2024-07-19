// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class GameEntity {
    let uuid = UUID()

    let face: GameEntityFace

    var dragging = false

    var dragAnchor: CGPoint?
    var rotationAnchor: CGFloat?
    var scaleAnchor: CGFloat?
    var selectedAction: ActionToken?

    var position: CGPoint {
        get { face.position }
        set { face.position = newValue }
    }

    // swiftlint:disable unused_setter_value
    var physicsBody: SKPPhysicsBody?
    var selectedPhysicsField: SKPPhysicsField?
    var selectedPhysicsJoint: SKPPhysicsJoint?
    var rotation: CGFloat { get { 0 } set { } }
    var scale: CGFloat { get { 1 } set { } }
    // swiftlint:enable unused_setter_value

    init(_ face: GameEntityFace) {
        self.face = face
    }

    func addActionToken(_ token: ActionToken) { }
    func getActionTokens() -> [ActionToken] { [] }

    func getActionsManager() -> ActionsManager? { nil }

    func restoreActionAnchors() { }

    func cancelActionsMode() { }
    func commitFollowPathAction(_ token: ActionToken) { }
    func commitPhysicsAction(_ token: ActionToken) { }
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
