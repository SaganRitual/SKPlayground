// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsBodyState: ObservableObject {
    @Published var angularDamping: CGFloat
    @Published var area: CGFloat
    @Published var charge: CGFloat
    @Published var density: CGFloat
    @Published var friction: CGFloat
    @Published var linearDamping: CGFloat
    @Published var mass: CGFloat
    @Published var restitution: CGFloat

    @Published var dynamism: Bool
    @Published var gravitism: Bool
    @Published var rotatism: Bool

    init(preview: Bool) {
        density = 1

        if preview {
            angularDamping = .random(in: 0...10)
            area = 1
            charge = .random(in: -10...10)
            friction = .random(in: 0...10)
            linearDamping = .random(in: 0...10)
            mass = .random(in: 0...10)
            restitution = .random(in: 0...10)

            dynamism = .random()
            gravitism = .random()
            rotatism = .random()
        } else {
            angularDamping = 0.1
            area = 1
            charge = 0
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
    }
}
