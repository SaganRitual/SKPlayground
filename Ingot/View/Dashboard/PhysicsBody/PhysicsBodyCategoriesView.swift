// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

final class CategorySwitches: ObservableObject {
    @Published var category: [Bool] = (0..<32).map { _ in Bool.random() }
    @Published var collision: [Bool] = (0..<32).map { _ in Bool.random() }
    @Published var contact: [Bool] = (0..<32).map { _ in Bool.random() }
}

struct PhysicsBodyCategoriesView: View {
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
    PhysicsBodyCategoriesView()
        .environmentObject(PlaygroundState())
}
