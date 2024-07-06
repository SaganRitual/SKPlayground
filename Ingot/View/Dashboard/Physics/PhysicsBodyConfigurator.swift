// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

final class PhysicsBodyRelay: ObservableObject {
    @Published var affectedByGravity = false
    @Published var allowsRotation = false
    @Published var angularDamping = CGFloat.zero
    @Published var charge = CGFloat.zero
    @Published var friction = CGFloat.zero
    @Published var isDynamic = false
    @Published var linearDamping = CGFloat.zero
    @Published var mass = CGFloat.zero
    @Published var restitution = CGFloat.zero
}

struct PhysicsBodyConfigurator: View {
    @EnvironmentObject var gameController: GameController

    @StateObject var physicsBodyRelay = PhysicsBodyRelay()
    @StateObject var physicsMaskNames = PhysicsMaskNames()

    var body: some View {
        VStack {
            PhysicsBodyTogglesView(physicsBodyRelay: physicsBodyRelay)
            PhysicsBodySlidersView(physicsBodyRelay: physicsBodyRelay)
            PhysicsBodyMasksView(physicsMaskNames: physicsMaskNames)
        }
        .padding(.vertical)
    }
}

#Preview {
    PhysicsBodyConfigurator()
        .environmentObject(GameController())
}
