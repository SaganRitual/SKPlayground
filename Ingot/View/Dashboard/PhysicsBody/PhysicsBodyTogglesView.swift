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
        VStack {
            HStack(spacing: 75) {
                Toggle(isOn: $playgroundState.physicsBodyHaver.dynamism) {
                    Text("Physics")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $playgroundState.physicsBodyHaver.gravitism) {
                    Text("Gravity")
                }
                .toggleStyle(.checkbox)

                Toggle(isOn: $playgroundState.physicsBodyHaver.rotatism) {
                    Text("Rotation")
                }
                .toggleStyle(.checkbox)
            }
            .padding()

            HStack {
                Text("Category")
                    .frame(width: 80, alignment: .leading)

                CheckboxPicker(
                    selectedIndices: $selectedCategoryIndices,
                    label: Text("Set Categories"),
                    options: playgroundState.physicsCategories.names
                )
                .frame(minWidth: 150)
            }

            HStack {
                Text("Collision")
                    .frame(width: 80, alignment: .leading)

                CheckboxPicker(
                    selectedIndices: $selectedCollisionIndices,
                    label: Text("Set Collision"),
                    options: playgroundState.physicsCategories.names
                )
                .frame(minWidth: 150)
            }

            HStack {
                Text("Contact")
                    .frame(width: 80, alignment: .leading)

                CheckboxPicker(
                    selectedIndices: $selectedContactIndices,
                    label: Text("Set Contact"),
                    options: playgroundState.physicsCategories.names
                )
                .frame(minWidth: 150)
            }
        }
    }
}

#Preview {
    PhysicsBodyTogglesView()
        .environmentObject(PlaygroundState())
}
