// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

final class PhysicsWorldRelay: ObservableObject {
    @Published var enableEdgeLoop = true
    @Published var currentCollisionMaskName = "Mask 0"
    @Published var currentContactMaskName = "Mask 0"
    @Published var gravity = CGVector.zero
    @Published var collideWith = Set<Int>()
    @Published var memberOf = Set<Int>()
    @Published var reportContactWith = Set<Int>()
    @Published var speed: CGFloat = 1

    private var subscriptions = Set<AnyCancellable>()

    deinit {
        subscriptions.forEach { $0.cancel() }
    }

    func loadState(from sceneManager: SKPScene) {
        enableEdgeLoop = sceneManager.isEdgeLoopEnabled()
        gravity = sceneManager.physicsWorld.gravity

        if let edgeLoop = sceneManager.edgeLoop {
            collideWith = Utility.makeIndexSet(edgeLoop.collisionBitMask)
            memberOf = Utility.makeIndexSet(edgeLoop.categoryBitMask)
            reportContactWith = Utility.makeIndexSet(edgeLoop.contactTestBitMask)
        }
    }

    func subscribe(sceneManager: SKPScene) {
        $collideWith.dropFirst().sink { [weak sceneManager] in
            sceneManager?.edgeLoop?.collisionBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $enableEdgeLoop.dropFirst().sink { [weak sceneManager] in
            sceneManager?.enableEdgeLoop($0)
        }
        .store(in: &subscriptions)

        $gravity.dropFirst().sink { [weak sceneManager] in
            sceneManager?.physicsWorld.gravity = $0
        }
        .store(in: &subscriptions)

        $memberOf.dropFirst().sink { [weak sceneManager] in
            sceneManager?.edgeLoop?.categoryBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $reportContactWith.dropFirst().sink { [weak sceneManager] in
            sceneManager?.edgeLoop?.contactTestBitMask = Utility.makeBitmask($0)
        }
        .store(in: &subscriptions)

        $speed.dropFirst().sink { [weak sceneManager] in
            sceneManager?.physicsWorld.speed = $0
        }
        .store(in: &subscriptions)
    }
}
