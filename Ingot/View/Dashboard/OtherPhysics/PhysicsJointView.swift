// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum PhysicsJointType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case fixed = "Fixed", limit = "Limit", pin = "Pin", sliding = "Sliding", spring = "Spring"
}

struct PhysicsJointView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var currentJoint: String = PhysicsJointType.fixed.rawValue

    let jointTypes = [
        "Fixed", "Limit", "Pin", "Sliding", "Spring"
    ]

    var body: some View {
        VStack {
            Picker("", selection: $currentJoint) {
                ForEach(jointTypes, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.segmented) // Use segmented control style for radio buttons
        }
    }
}

#Preview {
    PhysicsJointView()
        .environmentObject(PlaygroundState())
}
