// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

final class PhysicsBodyRelay: ObservableObject {
    @Published var affectedByGravity = false
    @Published var allowsRotation = false
    @Published var angularDamping = CGFloat.zero
    @Published var applyFields = Set<Int>()
    @Published var charge = CGFloat.zero
    @Published var collideWith = Set<Int>()
    @Published var friction = CGFloat.zero
    @Published var isDynamic = false
    @Published var linearDamping = CGFloat.zero
    @Published var mass = CGFloat.zero
    @Published var memberOf = Set<Int>()
    @Published var reportContactWith = Set<Int>()
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

        memberOf = Utility.makeIndexSet(body.categoryBitMask)
        applyFields = Utility.makeIndexSet(body.fieldBitMask)
        collideWith = Utility.makeIndexSet(body.collisionBitMask)
        reportContactWith = Utility.makeIndexSet(body.contactTestBitMask)
    }

    func subscribe(entityManager: EntityManager) {
        $affectedByGravity.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.affectedByGravity = $0
        }
        .store(in: &subscriptions)

        $allowsRotation.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.allowsRotation = $0
        }
        .store(in: &subscriptions)

        $angularDamping.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.angularDamping = $0
        }
        .store(in: &subscriptions)

        $applyFields.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.fieldBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $charge.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.charge = $0
        }
        .store(in: &subscriptions)

        $collideWith.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.collisionBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $friction.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.friction = $0
        }
        .store(in: &subscriptions)

        $isDynamic.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.isDynamic = $0
        }
        .store(in: &subscriptions)

        $linearDamping.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.linearDamping = $0
        }
        .store(in: &subscriptions)

        $mass.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.mass = $0
        }
        .store(in: &subscriptions)

        $memberOf.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.categoryBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $reportContactWith.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.contactTestBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $restitution.dropFirst().sink { [weak entityManager] in
            entityManager?.singleSelected()?.physicsBody?.restitution = $0
        }
        .store(in: &subscriptions)
    }
}
