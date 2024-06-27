// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsBodyState: ObservableObject {
    @Published var area: CGFloat = .random(in: 0...10)
    @Published var density: CGFloat = .random(in: 0...10)
    @Published var friction: CGFloat = .random(in: 0...10)
    @Published var mass: CGFloat = .random(in: 0...10)
    @Published var restitution: CGFloat = .random(in: 0...10)
    @Published var angularDamping: CGFloat = .random(in: 0...10)
    @Published var linearDamping: CGFloat = .random(in: 0...10)

    @Published var dynamism: Bool = false
    @Published var gravitism: Bool = false
    @Published var rotatism: Bool = false
}
