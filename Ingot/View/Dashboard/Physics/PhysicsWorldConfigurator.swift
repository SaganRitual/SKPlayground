// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

final class PhysicsWorldRelay: ObservableObject {
    @Published var enableEdgeLoop = true
    @Published var currentCollisionMaskName = "Mask 0"
    @Published var currentContactMaskName = "Mask 0"
    @Published var gravity = CGVector.zero
    @Published var selectedCollisionIndices = Set<Int>()
    @Published var selectedContactIndices = Set<Int>()
}

struct PhysicsWorldConfigurator: View {
    @StateObject var physicsMaskNames = PhysicsMaskNames()
    @StateObject var physicsWorldRelay = PhysicsWorldRelay()

    var body: some View {
        VStack {
            PhysicsWorldSlidersView(physicsWorldRelay: physicsWorldRelay)
            PhysicsWorldEdgeLoopView(physicsMaskNames: physicsMaskNames, physicsWorldRelay: physicsWorldRelay)
            PhysicsMaskNamesConfigurator(physicsMaskNames: physicsMaskNames)
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsWorldConfigurator()
}
