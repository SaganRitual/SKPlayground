// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class GameEntity {
    let uuid = UUID()

    var avatar: GameEntitySprite? { nil }

    var dragAnchor: CGPoint?
    var dragging = false

    var rotationAnchor: CGFloat?
    var scaleAnchor: CGFloat?

    var halo: SelectionHalo? { nil }

    var physicsBody: SKPhysicsBody? { get { nil } set { } }

    var position: CGPoint {
        get { avatar?.sceneNode.position ?? .zero }
        set {
            avatar?.sceneNode.position = newValue
            halo?.sceneNode.position = newValue
        }
    }

    var rotation: CGFloat { get { 0 } set { } }

    var scale: CGFloat { get { 1 } set { } }

    func addActionToken(_ token: any ActionTokenProtocol) { }
    func getActionTokens() -> [ActionTokenContainer] { [] }

    func restoreActionAnchors() { }

    func setAssignActionsMode(_ setIt: Bool) {
        halo?.setSelectionMode(setIt ? .assignActions : .normal)
    }

    func cancelActionsMode() { }
    func commitActions(duration: TimeInterval) { }
    func startActionsMode() { }
}

extension GameEntity: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    static func == (lhs: GameEntity, rhs: GameEntity) -> Bool {
        return lhs === rhs
    }
}
