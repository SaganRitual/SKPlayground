// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class SelectionHalo: GameEntitySprite {
    static let radius = 25.0

    var dragAnchor: CGPoint = .zero
    var isSelected: Bool { !sceneNode.isHidden }

    var haloShapeNode: SKShapeNode { Utility.forceCast(sceneNode, to: SKShapeNode.self) }

    init() {
        let shape = SKShapeNode(circleOfRadius: Self.radius)

        shape.lineWidth = 1
        shape.strokeColor = .green
        shape.fillColor = .clear
        shape.blendMode = .replace
        shape.isHidden = true
        shape.name = "MoveHandleShape"

        super.init(sceneNode: shape)
    }

    func deselect() { sceneNode.isHidden = true }
    func select() { sceneNode.isHidden = false }
    func toggleSelect() { sceneNode.isHidden = !sceneNode.isHidden }

    enum OrderIndicator { case first, inner, last }

    enum SelectionMode {
        case normal, assignActions
        case orderIndicator(OrderIndicator)
    }

    func setSelectionMode(_ mode: SelectionMode) {
        switch mode {
        case .normal:
            haloShapeNode.strokeColor = .green
        case .assignActions:
            haloShapeNode.strokeColor = .orange
        case .orderIndicator(let oi):
            switch oi {
            case .first:
                haloShapeNode.strokeColor = .green
            case .inner:
                haloShapeNode.strokeColor = .blue
            case .last:
                haloShapeNode.strokeColor = .red
            }
        }
    }
}
