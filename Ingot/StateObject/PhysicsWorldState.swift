// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class PhysicsWorldState: ObservableObject {
    @Published var enableGravity = false
    @Published var gravity: CGVector = .zero
    @Published var speed: CGFloat = 1
}
