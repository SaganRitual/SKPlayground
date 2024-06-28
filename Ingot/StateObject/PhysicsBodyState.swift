// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsBodyState: ObservableObject {
    @Published var angularDamping: CGFloat = .random(in: 0...10)
    @Published var area: CGFloat = .random(in: 0...10)
    @Published var density: CGFloat = .random(in: 0...10)
    @Published var friction: CGFloat = .random(in: 0...10)
    @Published var linearDamping: CGFloat = .random(in: 0...10)
    @Published var mass: CGFloat = .random(in: 0...10)
    @Published var restitution: CGFloat = .random(in: 0...10)

    @Published var dynamism: Bool = .random()
    @Published var gravitism: Bool = .random()
    @Published var rotatism: Bool = .random()

    @Published var hasPhysicsBody: Bool = false

    init(preview: Bool) {
        density = 1

        if preview {
            angularDamping = .random(in: 0...10)
            friction = .random(in: 0...10)
            linearDamping = .random(in: 0...10)
            mass = .random(in: 0...10)
            restitution = .random(in: 0...10)

            dynamism = .random()
            gravitism = .random()
            rotatism = .random()
        } else {
            angularDamping = 0.1
            friction = 0.2
            linearDamping = 0.1
            mass = 1
            restitution = 0.2

            dynamism = true
            gravitism = true
            rotatism = true
        }
    }

    func load(_ body: SKPhysicsBody) {
        angularDamping = body.angularDamping
        area = body.area
        density = body.density
        friction = body.friction
        linearDamping = body.linearDamping
        mass = body.mass
        restitution = body.restitution

        dynamism = body.isDynamic
        gravitism = body.affectedByGravity
        rotatism = body.allowsRotation

        hasPhysicsBody = true
    }
}
