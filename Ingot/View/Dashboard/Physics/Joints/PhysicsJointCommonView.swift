// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsJointViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PhysicsJointCommonView<T: PhysicsJointRelay>: View {
    @ObservedObject var relay: T

    var body: some View {
        HStack {
            Text(String(format: "Reaction Force \(Utility.vectorString(relay.reactionForce))"))
            Text(String(format: "Reaction Torque %.2f", relay.reactionTorque))
        }
    }
}
