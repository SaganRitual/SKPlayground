// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation

final class PhysicsWorldRelay: ObservableObject {
    @Published var enableEdgeLoop = true
    @Published var currentCollisionMaskName = "Mask 0"
    @Published var currentContactMaskName = "Mask 0"
    @Published var gravity = CGVector.zero
    @Published var selectedCollisionIndices = Set<Int>()
    @Published var selectedContactIndices = Set<Int>()
}
