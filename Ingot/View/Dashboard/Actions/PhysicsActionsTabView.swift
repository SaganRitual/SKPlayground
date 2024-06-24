// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsActionsTabView: View {
    enum PhysicsActionType: String, CaseIterable, Identifiable { // Add Identifiable to use with Picker
        case force = "Force", torque = "Torque", impulse = "Impulse", angularImpulse = "Θ-impulse"
        var id: Self { self } // Implementation for Identifiable
    }

    @State private var selectedType = PhysicsActionType.force
    @State private var duration: Double = 2
    @State private var positionVector: CGVector = .zero
    @State private var forceVector: CGVector = .zero
    @State private var torqueValue: Double = 0.0

    var body: some View {
        VStack {
            Picker("Action", selection: $selectedType) {
                ForEach(PhysicsActionType.allCases) { type in
                    Text(type.rawValue.capitalized).tag(type)
                }
            }
            .pickerStyle(.segmented) // Use segmented control style for radio buttons

            Spacer()

            if selectedType == .force || selectedType == .impulse {
                let text = selectedType == .force ? "Force" : "Impulse"

                HStack {
                    Slider2DView(
                        output: $forceVector,
                        size: CGSize(width: 100, height: 100),
                        snapTolerance: 5,
                        title: Text("\(text) Vector"),
                        virtualSize: CGSize(width: 20, height: 20)
                    )

                    Slider2DView(
                        output: $positionVector,
                        size: CGSize(width: 100, height: 100),
                        snapTolerance: 5,
                        title: Text("Where"),
                        virtualSize: CGSize(width: 20, height: 20)
                    )
                }
            } else {
                VStack {
                    Text("Torque: \(String(format: "%.2f", torqueValue))")
                        .padding(.top)

                    HStack {
                        Text("-10")
                        Slider(value: $torqueValue, in: -10...10)
                        Text("10")
                    }
                    .padding([.horizontal])
                }
            }

            Spacer()

            VStack {
                Text("Duration: \(String(format: "%.2f", duration))")
                    .padding(.top)

                HStack {
                    Text("0.1")
                    Slider(value: $duration, in: 0.1...5)
                    Text("5.0")
                }
                .padding([.horizontal])
            }

            Button("Create Physics Action") {
                // 1. Create the appropriate Physics Action (force, impulse, torque, or angular impulse)
                // 2. Use forceVector or torqueValue, and duration as needed
                // 3. Attach the action to the entity
            }
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    PhysicsActionsTabView()
}
