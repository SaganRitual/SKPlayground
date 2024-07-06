// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class PhysicsFieldRelay: ObservableObject {
    @Published var fieldType: PhysicsFieldType = .allCases.randomElement()!

    @Published var animationSpeed: Float = .random(in: 0...10)
    @Published var direction: CGVector = .random(in: -100...100)
    @Published var enabled: Bool = .random()
    @Published var exclusive: Bool = .random()
    @Published var falloff: Float = .random(in: 0...100)
    @Published var minimumRadius: Float = .random(in: 0...100)
    @Published var region: SKRegion?
    @Published var smoothness: Float = .random(in: 0...100)
    @Published var strength: Float = .random(in: 0...100)

    func loadState(from entity_: GameEntity) {
        let entity = Utility.forceCast(entity_, to: Field.self)
        let fieldNode_ = entity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
        let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

        fieldType = Utility.forceCast(fieldNode.userData?["fieldType"], to: PhysicsFieldType.self)

        animationSpeed = fieldNode.animationSpeed
        direction = CGVector(fieldNode.direction)
        enabled = fieldNode.isEnabled
        exclusive = fieldNode.isExclusive
        falloff = fieldNode.falloff
        minimumRadius = fieldNode.minimumRadius
        region = fieldNode.region
        smoothness = fieldNode.smoothness
        strength = fieldNode.strength
    }
}
