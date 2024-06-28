// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsActionsTabView: View {
    @EnvironmentObject var gameController: GameController

    enum PhysicsActionType: String, CaseIterable, Identifiable { // Add Identifiable to use with Picker
        case force = "Force", torque = "Torque", impulse = "Impulse", angularImpulse = "Θ-impulse"
        var id: Self { self } // Implementation for Identifiable
    }

    @State private var selectedType = PhysicsActionType.force
    @State private var duration: Double = 2
    @State private var position: CGPoint = .zero
    @State private var positionPair: ABPair = ABPair(a: 0, b: 0)
    @State private var force: CGVector = .zero
    @State private var forcePair: ABPair = ABPair(a: 0, b: 0)
    @State private var torque: Double = 0.0

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
                        output: $forcePair,
                        size: CGSize(width: 100, height: 100),
                        snapTolerance: 5,
                        title: Text("\(text) Vector"),
                        virtualSize: CGSize(width: 20, height: 20)
                    )
                    .onChange(of: forcePair) {
                        force = CGVector(forcePair)
                    }

                    Slider2DView(
                        output: $positionPair,
                        size: CGSize(width: 100, height: 100),
                        snapTolerance: 5,
                        title: Text("Where"),
                        virtualSize: CGSize(width: 20, height: 20)
                    )
                    .onChange(of: positionPair) {
                        position = CGPoint(positionPair)
                    }
                }
            } else {
                VStack {
                    Text("Torque: \(String(format: "%.2f", torque))")
                        .padding(.top)

                    HStack {
                        Text("-10")
                        Slider(value: $torque, in: -10...10)
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
                let actionToken: ActionTokenProtocol

                switch selectedType {
                case .force:
                    actionToken = ForceActionToken(duration: duration, focus: position, force: force)
                case .torque:
                    actionToken = TorqueActionToken(duration: duration, torque: torque)
                case .impulse:
                    actionToken = ImpulseActionToken(duration: duration, focus: position, impulse: force)
                case .angularImpulse:
                    actionToken = AngularImpulseActionToken(duration: duration, angularImpulse: torque)
                }

                gameController.commitPhysicsAction(actionToken)
            }
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    PhysicsActionsTabView()
}
