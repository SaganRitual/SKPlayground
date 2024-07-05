// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsWorldView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var physicsMaskCategories: PhysicsMaskCategories
    @EnvironmentObject var physicsWorldState: PhysicsWorldState

    @State private var currentCategoryName = "Category 0"
    @State private var enableEdgeLoop = false
    @State private var gravityPair = ABPair(a: 0, b: 0)

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var showDuplicateAlert = false
    @State private var duplicateCategoryIndex = 0

    var body: some View {
        VStack {
            HStack {
                Slider2DView(
                    output: $gravityPair,
                    size: CGSize(width: 100, height: 100),
                    snapTolerance: 5,
                    title: Text("Gravity"),
                    virtualSize: CGSize(width: 20, height: 20)
                )
                .padding(.trailing)
                .onChange(of: gravityPair) {
                    let gv = CGVector(gravityPair)
                    physicsWorldState.gravity = gv
                    gameController.setGravity(gv)
                }

                VStack(alignment: .leading) {
                    HStack {
                        Picker("Category Names", selection: $currentCategoryName) {
                            ForEach(physicsMaskCategories.names, id: \.self) { name in
                                Text(name)
                            }
                        }
                        .pickerStyle(.menu)

                        Button("Rename") {
                            editedName = currentCategoryName
                            isEditing = true
                        }
                    }
                    .padding(.top)
                    .sheet(isPresented: $isEditing) { // Sheet for editing
                        VStack {
                            TextField("New Name", text: $editedName)
                                .padding()

                            HStack {
                                Button("Save") {
                                    if let duplicateIx = physicsMaskCategories.renameCategory(
                                        currentName: currentCategoryName, newName: editedName
                                    ) {
                                        duplicateCategoryIndex = duplicateIx
                                        showDuplicateAlert = true
                                    } else {
                                        currentCategoryName = editedName
                                    }
                                    isEditing = false
                                }

                                Button("Cancel") {
                                    isEditing = false
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showDuplicateAlert) {  // Alert now bound to state
                        Alert(
                            title: Text("Category names must be unique"),
                            message: Text(
                                "There is already a category called "
                                + "\(physicsMaskCategories.names[duplicateCategoryIndex])"
                            ),
                            dismissButton: .cancel()
                        )
                    }

                    Toggle(isOn: $enableEdgeLoop) {
                        Text("Full Scene Edge Loop")
                    }
                    .toggleStyle(.checkbox)
                    .padding(.top, 30)
                    .onChange(of: enableEdgeLoop) {
                        gameController.enableSceneEdgeLoop(enableEdgeLoop)
                    }
                    .onAppear {
                        enableEdgeLoop = gameController.getSceneEdgeLoopEnabled()
                    }

                    EdgeLoopCategoriesView()
                }
            }
        }
        .padding()
        .frame(width: 700, height: 400)
        .onAppear {
            physicsWorldState.gravity = gameController.getGravity()
            physicsWorldState.speed = gameController.getPhysicsSpeed()
        }
    }
}

#Preview {
    PhysicsWorldView()
        .environmentObject(GameController())
        .environmentObject(PhysicsMaskCategories())
        .environmentObject(PhysicsWorldState())
}
