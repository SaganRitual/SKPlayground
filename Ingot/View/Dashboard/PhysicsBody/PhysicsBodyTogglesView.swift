// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

final class CategorySwitches: ObservableObject {
    @Published var category: [Bool] = (0..<32).map { _ in Bool.random() }
    @Published var collision: [Bool] = (0..<32).map { _ in Bool.random() }
    @Published var contact: [Bool] = (0..<32).map { _ in Bool.random() }
}

struct PhysicsBodyTogglesView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var currentCategoryName = "Category foo"
    @State private var currentCollisionName = "Category bar"
    @State private var currentContactName = "Category goo"

    @StateObject private var switches = CategorySwitches()

    @State private var selectedCategoryIndices = Set<Int>()
    @State private var selectedCollisionIndices = Set<Int>()
    @State private var selectedContactIndices = Set<Int>()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Toggle(isOn: $playgroundState.physicsBodyHaver.dynamism) {
                    Text("Apply Physics")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $playgroundState.physicsBodyHaver.gravitism) {
                    Text("Apply Gravity")
                }
                .toggleStyle(.checkbox)
                .disabled(!playgroundState.physicsBodyHaver.dynamism)

                Toggle(isOn: $playgroundState.physicsBodyHaver.rotatism) {
                    Text("Allow Rotation")
                }
                .toggleStyle(.checkbox)
                .disabled(!playgroundState.physicsBodyHaver.dynamism)
            }
            .padding()

            VStack {
                CheckboxPicker(
                    selectedIndices: $selectedCategoryIndices,
                    label: Text("Mask Categories"),
                    options: playgroundState.physicsCategories.names
                )
                .frame(minWidth: 100)

                CheckboxPicker(
                    selectedIndices: $selectedCollisionIndices,
                    label: Text("Collision Mask"),
                    options: playgroundState.physicsCategories.names
                )
                .frame(minWidth: 100)

                CheckboxPicker(
                    selectedIndices: $selectedContactIndices,
                    label: Text("Contact Mask"),
                    options: playgroundState.physicsCategories.names
                )
                .frame(minWidth: 100)
            }
            .padding()
        }
    }
}

#Preview {
    PhysicsBodyTogglesView()
        .environmentObject(PlaygroundState())
}
