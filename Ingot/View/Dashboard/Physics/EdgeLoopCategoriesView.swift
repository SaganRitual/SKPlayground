// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct EdgeLoopCategoriesView: View {
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
                    let edge = Utility.forceCast(gameController.gameScene.cachedEdgeLoop, to: SKPhysicsBody.self)
                    edge.categoryBitMask = Utility.makeBitmask(selectedCategoryIndices)
                }

                CheckboxPicker(
                    selectedIndices: $selectedCollisionIndices,
                    label: Text("Collision Mask"),
                    options: physicsMaskCategories.names
                )
                .frame(minWidth: 100)
                .onChange(of: selectedCollisionIndices) {
                    let edge = Utility.forceCast(gameController.gameScene.cachedEdgeLoop, to: SKPhysicsBody.self)
                    edge.collisionBitMask = Utility.makeBitmask(selectedCollisionIndices)
                }

                CheckboxPicker(
                    selectedIndices: $selectedContactIndices,
                    label: Text("Contact Mask"),
                    options: physicsMaskCategories.names
                )
                .frame(minWidth: 100)
                .onChange(of: selectedContactIndices) {
                    let edge = Utility.forceCast(gameController.gameScene.cachedEdgeLoop, to: SKPhysicsBody.self)
                    edge.contactTestBitMask = Utility.makeBitmask(selectedContactIndices)
                }
            }
            .padding()
        }
    }
}

#Preview {
    EdgeLoopCategoriesView()
}
