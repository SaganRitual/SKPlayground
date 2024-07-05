// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsFieldState: ObservableObject {
    @Published var fieldType: PhysicsFieldType = .allCases.randomElement()!

    @Published var animationSpeed: CGFloat = .random(in: 0...10)
    @Published var direction: CGVector = .random(in: -100...100)
    @Published var enabled: Bool = .random()
    @Published var exclusive: Bool = .random()
    @Published var falloff: CGFloat = .random(in: 0...100)
    @Published var minimumRadius: CGFloat = .random(in: 0...100)
    @Published var region: SKRegion?
    @Published var smoothness: CGFloat = .random(in: 0...100)
    @Published var strength: CGFloat = .random(in: 0...100)

    func loadState(from entity_: GameEntity) {
        let entity = Utility.forceCast(entity_, to: Field.self)
        let fieldNode_ = entity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
        let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

        fieldType = Utility.forceCast(fieldNode.userData?["fieldType"], to: PhysicsFieldType.self)

        animationSpeed = CGFloat(fieldNode.animationSpeed)
        direction = CGVector(fieldNode.direction)
        enabled = fieldNode.isEnabled
        exclusive = fieldNode.isExclusive
        falloff = CGFloat(fieldNode.falloff)
        minimumRadius = CGFloat(fieldNode.minimumRadius)
        region = fieldNode.region
        smoothness = CGFloat(fieldNode.smoothness)
        strength = CGFloat(fieldNode.strength)
    }
}

extension CGVector {
    init(_ oldStyleVector: vector_float3) {
        self.init(dx: CGFloat(oldStyleVector.x), dy: CGFloat(oldStyleVector.y))
    }
}
