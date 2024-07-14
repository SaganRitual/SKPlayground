// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit
import SwiftUI

class FieldSprite: GameEntitySprite {
    let symbolNames: [PhysicsFieldType: String] = [
        .drag: "wind",
        .electric: "bolt.fill",
        .linearGravity: "arrow.down.to.line.alt",
        .magnetic: "wand.and.stars",
        .noise: "speaker.wave.2.fill",
        .radialGravity: "arrow.up.left.and.arrow.down.right",
        .spring: "figure.walk",
        .turbulence: "airplane",
        .velocity: "speedometer",
        .vortex: "tornado"
    ]

    init(_ fieldType: PhysicsFieldType) {
        let symbolName = Utility.forceCast(symbolNames[fieldType], to: String.self)
        let image = Image(systemName: symbolName).font(.title)

        // Thanks Oskar!
        // https://stackoverflow.com/a/69315037/1610473
        let renderedByOskar = image.renderAsImage()!

        let texture = SKTexture(image: renderedByOskar)
        let sprite = SKSpriteNode(texture: texture)

        sprite.color = .yellow
        sprite.colorBlendFactor = 1

        super.init(sceneNode: sprite)
    }
}

final class Field: GameEntity {
    let physicsField: SKFieldNode

    static func make(at position: CGPoint, fieldType: PhysicsFieldType) -> Field {
        let fieldNode = makeFieldNode(fieldType)
        fieldNode.userData = ["fieldType": fieldType]

        let field = Field(fieldNode, at: position)
        field.face.setOwnerEntity(field)

        return field
    }

    static func makeFieldNode(_ fieldType: PhysicsFieldType) -> SKFieldNode {
        switch fieldType {
        case .drag:
            SKFieldNode.dragField()
        case .electric:
            SKFieldNode.electricField()
        case .linearGravity:
            SKFieldNode.linearGravityField(withVector: vector_float3(0, 0, 0))
        case .magnetic:
            SKFieldNode.magneticField()
        case .noise:
            SKFieldNode.noiseField(withSmoothness: 1, animationSpeed: 1)
        case .radialGravity:
            SKFieldNode.radialGravityField()
        case .spring:
            SKFieldNode.springField()
        case .turbulence:
            SKFieldNode.turbulenceField(withSmoothness: 1, animationSpeed: 1)
        case .velocity:
            SKFieldNode.velocityField(withVector: vector_float3(0, 0, 0))
        case .vortex:
            SKFieldNode.vortexField()
        }
    }

    init(_ fieldNode: SKFieldNode, at position: CGPoint) {
        self.physicsField = fieldNode

        let halo = SelectionHalo()

        let fieldType = Utility.forceCast(fieldNode.userData?["fieldType"], to: PhysicsFieldType.self)
        let avatar = FieldSprite(fieldType)

        let face = GameEntityFace(at: position, avatar: avatar, halo: halo)
        super.init(face)
    }
}
