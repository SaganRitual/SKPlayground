// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
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

    private var subscriptions = Set<AnyCancellable>()

    deinit {
        subscriptions.forEach { $0.cancel() }
    }

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

    func subscribe(entityManager: EntityManager) {
        $affectedByGravity.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.affectedByGravity = $0
        }
        .store(in: &subscriptions)

        $allowsRotation.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.allowsRotation = $0
        }
        .store(in: &subscriptions)

        $angularDamping.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.angularDamping = $0
        }
        .store(in: &subscriptions)

        $charge.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.charge = $0
        }
        .store(in: &subscriptions)

        $friction.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.friction = $0
        }
        .store(in: &subscriptions)

        $isDynamic.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.isDynamic = $0
        }
        .store(in: &subscriptions)

        $linearDamping.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.linearDamping = $0
        }
        .store(in: &subscriptions)

        $mass.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.mass = $0
        }
        .store(in: &subscriptions)

        $restitution.sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.restitution = $0
        }
        .store(in: &subscriptions)
    }
}
