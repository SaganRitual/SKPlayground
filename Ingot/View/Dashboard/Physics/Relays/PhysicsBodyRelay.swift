// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

final class PhysicsBodyRelay: ObservableObject {
    @Published var affectedByGravity = false
    @Published var allowsRotation = false
    @Published var angularDamping = CGFloat.zero
    @Published var charge = CGFloat.zero
    @Published var friction = CGFloat.zero
    @Published var isDynamic = false
    @Published var linearDamping = CGFloat.zero
    @Published var mass = CGFloat.zero
    @Published var restitution = CGFloat.zero

    func loadState(from entity_: GameEntity) {
        let entity = Utility.forceCast(entity_, to: Gremlin.self)
        let body = Utility.forceCast(entity.physicsBody, to: SKPhysicsBody.self)

        affectedByGravity = body.affectedByGravity
        allowsRotation = body.allowsRotation
        angularDamping = body.angularDamping
        charge = body.charge
        friction = body.friction
        isDynamic = body.isDynamic
        linearDamping = body.linearDamping
        mass = body.mass
        restitution = body.restitution
    }
}
