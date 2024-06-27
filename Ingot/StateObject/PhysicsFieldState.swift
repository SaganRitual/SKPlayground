// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

class PhysicsFieldState: ObservableObject {
    @Published var fieldType: PhysicsFieldType = .allCases.randomElement()!

    @Published var animationSpeed: CGFloat = .random(in: 0...10)
    @Published var direction: CGVector = .random(in: -100...100)
    @Published var enabled: Bool = .random()
    @Published var exclusive: Bool = .random()
    @Published var falloff: CGFloat = .random(in: 0...100)
    @Published var minimumRadius: CGFloat = .random(in: 0...100)
    @Published var region: CGSize = .zero
    @Published var smoothness: CGFloat = .random(in: 0...100)
    @Published var strength: CGFloat = .random(in: 0...100)
}
