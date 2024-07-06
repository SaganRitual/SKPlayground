// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

final class CategorySwitches: ObservableObject {
    @Published var category: [Bool] = (0..<32).map { _ in Bool.random() }
    @Published var collision: [Bool] = (0..<32).map { _ in Bool.random() }
    @Published var contact: [Bool] = (0..<32).map { _ in Bool.random() }
}

struct PhysicsBodyCategoriesView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var physicsMaskCategories: PhysicsMaskCategories

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
                    options: physicsMaskCategories.names
                )
                .frame(minWidth: 100)
                .onChange(of: selectedCategoryIndices) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let entity = gameController.getSelected().first else { return }
                    let body = Utility.forceCast(entity.physicsBody, to: SKPhysicsBody.self)

                    body.fieldBitMask = Utility.makeBitmask(selectedCategoryIndices)
                }

                CheckboxPicker(
                    selectedIndices: $selectedCollisionIndices,
                    label: Text("Collision Mask"),
                    options: physicsMaskCategories.names
                )
                .frame(minWidth: 100)
                .onChange(of: selectedCollisionIndices) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let entity = gameController.getSelected().first else { return }
                    let body = Utility.forceCast(entity.physicsBody, to: SKPhysicsBody.self)

                    body.collisionBitMask = Utility.makeBitmask(selectedCollisionIndices)
                }

                CheckboxPicker(
                    selectedIndices: $selectedContactIndices,
                    label: Text("Contact Mask"),
                    options: physicsMaskCategories.names
                )
                .frame(minWidth: 100)
                .onChange(of: selectedContactIndices) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let entity = gameController.getSelected().first else { return }
                    let body = Utility.forceCast(entity.physicsBody, to: SKPhysicsBody.self)

                    body.contactTestBitMask = Utility.makeBitmask(selectedContactIndices)
                }
            }
        }
    }
}

#Preview {
    PhysicsBodyCategoriesView()
        .environmentObject(PhysicsMaskCategories())
}
