// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SpriteKit

class PhysicsBody: ObservableObject {
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

class PhysicsField: ObservableObject {
    @Published var fieldType: PhysicsFieldType = .allCases.randomElement()!

    @Published var animationSpeed: CGFloat = .random(in: 0...10)
    @Published var direction: CGVector = .random(in: -100...100)
    @Published var enabled: Bool = .random()
    @Published var exclusive: Bool = .random()
    @Published var falloff: CGFloat = .random(in: 0...100)
    @Published var minimumRadius: CGFloat = .random(in: 0...100)
    @Published var region: SKRegion? = nil
    @Published var smoothness: CGFloat = .random(in: 0...100)
    @Published var strength: CGFloat = .random(in: 0...100)
}

final class Categories: ObservableObject {
    @Published var names: [String] = (0..<32).map { "Category \($0)" }

    func renameCategory(currentName: String, newName: String) -> Int? {
        if let index = names.firstIndex(of: newName) {
            return index
        }

        if let index = names.firstIndex(of: currentName) {
            names[index] = newName
        }

        return nil
    }
}

