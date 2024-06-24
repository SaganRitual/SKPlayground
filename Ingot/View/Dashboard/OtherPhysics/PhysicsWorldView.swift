// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

extension VerticalAlignment {
    private enum GravityToggleAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center] // Align to center by default
        }
    }

    static let gravityToggleAlignment = VerticalAlignment(GravityToggleAlignment.self)
}

struct PhysicsWorldView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var currentCategoryName = "Category 0"
    @State private var enableEdgeLoop = false
    @State private var enableGravity = false
    @State private var gravity = CGVector(dx: 0, dy: -9.8)
    @State private var speed: CGFloat = 1

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var showDuplicateAlert = false
    @State private var duplicateCategoryIndex = 0

    var gravityToggle: some View {
        Toggle(isOn: $enableGravity) {
            Text("Gravity")
        }
        .toggleStyle(.checkbox)
        .alignmentGuide(.gravityToggleAlignment) { dimensions in
            dimensions[VerticalAlignment.center]  // Align Slider2DView to center
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .gravityToggleAlignment) {
                Slider2DView(
                    output: $gravity,
                    size: CGSize(width: 100, height: 100),
                    snapTolerance: 5,
                    title: gravityToggle,
                    virtualSize: CGSize(width: 20, height: 20)
                )
                .padding(.trailing)

                VStack(alignment: .leading) {
                    VStack(alignment: .center) {
                        Text("Speed: \(String(format: "%.2f", speed))")
                            .alignmentGuide(.gravityToggleAlignment) { dimensions in
                                dimensions[VerticalAlignment.center]  // Align "Speed" text to center
                            }

                        HStack {
                            Text("0.0")
                            Slider(value: $speed, in: 0...1)
                            Text("1.0")
                        }
                        .padding([.horizontal])
                    }
                    .padding(.bottom)

                    Toggle(isOn: $enableEdgeLoop) {
                        Text("Full Scene Edge Loop")
                    }
                    .toggleStyle(.checkbox)
                    .padding([.leading, .bottom])

                    HStack {
                        Picker("Categories", selection: $currentCategoryName) {
                            ForEach(playgroundState.physicsCategories.names, id: \.self) { name in
                                Text(name)
                            }
                        }
                        .pickerStyle(.menu)

                        Button("Rename Category") {
                            editedName = currentCategoryName
                            isEditing = true
                        }
                    }
                    .sheet(isPresented: $isEditing) { // Sheet for editing
                        VStack {
                            TextField("New Name", text: $editedName)
                                .padding()

                            HStack {
                                Button("Save") {
                                    if let duplicateIx = playgroundState.physicsCategories.renameCategory(currentName: currentCategoryName, newName: editedName) {
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
                        message: Text("There is already a category called \(playgroundState.physicsCategories.names[duplicateCategoryIndex])"),
                        dismissButton: .cancel()
                      )
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PhysicsWorldView()
        .environmentObject(PlaygroundState())
}
