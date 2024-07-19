// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

final class PhysicsFieldRelay: ObservableObject {
    @Published var fieldType: PhysicsFieldType = .allCases.randomElement()!

    @Published var animationSpeed: Float = .random(in: 0...10)
    @Published var applyTo = Set<Int>()
    @Published var direction: CGVector = .random(in: -100...100)
    @Published var enabled: Bool = .random()
    @Published var exclusive: Bool = .random()
    @Published var falloff: Float = .random(in: 0...100)
    @Published var gravityX: Float = .random(in: 0...100)
    @Published var gravityY: Float = .random(in: 0...100)
    @Published var minimumRadius: Float = .random(in: 0...100)
    @Published var region: SKRegion?
    @Published var smoothness: Float = .random(in: 0...100)
    @Published var strength: Float = .random(in: 0...100)

    private var subscriptions = Set<AnyCancellable>()

    deinit {
        subscriptions.forEach { $0.cancel() }
    }

    static func selectedField(entityManager: EntityManager?) -> Field? {
        (entityManager?.singleSelected() as? Field)
    }

    func loadState(from entity_: GameEntity) {
        let entity = Utility.forceCast(entity_, to: Field.self)
        let fieldNode_ = entity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
        let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)

        fieldType = Utility.forceCast(fieldNode.userData?["fieldType"], to: PhysicsFieldType.self)

        animationSpeed = fieldNode.animationSpeed
        applyTo = Utility.makeIndexSet(fieldNode.categoryBitMask)
        direction = CGVector(fieldNode.direction)
        enabled = fieldNode.isEnabled
        exclusive = fieldNode.isExclusive
        falloff = fieldNode.falloff
        minimumRadius = fieldNode.minimumRadius
        region = fieldNode.region
        smoothness = fieldNode.smoothness
        strength = fieldNode.strength
    }

    func subscribe(entityManager: EntityManager) {
        $animationSpeed.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.animationSpeed = $0
        }
        .store(in: &subscriptions)

        $applyTo.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.categoryBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $gravityX.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.direction.x = $0
        }
        .store(in: &subscriptions)

        $gravityY.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.direction.y = $0
        }
        .store(in: &subscriptions)

        $enabled.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.isEnabled = $0
        }
        .store(in: &subscriptions)

        $exclusive.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.isExclusive = $0
        }
        .store(in: &subscriptions)

        $falloff.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.falloff = $0
        }
        .store(in: &subscriptions)

        $minimumRadius.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.minimumRadius = $0
        }
        .store(in: &subscriptions)

        $region.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.region = $0
        }
        .store(in: &subscriptions)

        $smoothness.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.smoothness = $0
        }
        .store(in: &subscriptions)

        $strength.dropFirst().sink { [weak entityManager] in
            Self.selectedField(entityManager: entityManager)?.physicsField.strength = $0
        }
        .store(in: &subscriptions)
    }
}
