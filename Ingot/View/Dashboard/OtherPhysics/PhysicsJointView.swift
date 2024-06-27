// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

enum PhysicsJointType: String, CaseIterable, Identifiable, RawRepresentable {
    var id: String { self.rawValue }

    case fixed = "Fixed", limit = "Limit", pin = "Pin", sliding = "Sliding", spring = "Spring"
}

struct PhysicsJointView: View {
    @State private var selectedJointType: PhysicsJointType = .fixed

    var body: some View {
        VStack {
            Picker("", selection: $selectedJointType) {
                ForEach(PhysicsJointType.allCases, id: \.self) { jointType in
                    Text(jointType.rawValue).tag(jointType)
                }
            }
            .pickerStyle(.segmented) // Use segmented control style for radio buttons
        }
    }
}

#Preview {
    PhysicsJointView()
}
