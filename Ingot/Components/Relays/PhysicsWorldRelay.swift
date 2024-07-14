// We are a way for the cosmos to know itself. -- C. Sagan

import Combine
import Foundation
import SpriteKit

final class PhysicsWorldRelay: ObservableObject {
    @Published var enableEdgeLoop = true
    @Published var currentCollisionMaskName = "Mask 0"
    @Published var currentContactMaskName = "Mask 0"
    @Published var gravity = CGVector.zero
    @Published var selectedCollisionIndices = Set<Int>()
    @Published var selectedContactIndices = Set<Int>()

    private var subscriptions = Set<AnyCancellable>()

    deinit {
        subscriptions.forEach { $0.cancel() }
    }

    func loadState(from sceneManager: SKPScene) {
        enableEdgeLoop = sceneManager.isEdgeLoopEnabled()
        gravity = sceneManager.physicsWorld.gravity
    }

    func subscribe(sceneManager: SKPScene) {
        $enableEdgeLoop.sink { [weak sceneManager] in
            sceneManager?.enableEdgeLoop($0)
        }
        .store(in: &subscriptions)

        $gravity.sink { [weak sceneManager] in
            sceneManager?.physicsWorld.gravity = $0
        }
        .store(in: &subscriptions)
    }
}
