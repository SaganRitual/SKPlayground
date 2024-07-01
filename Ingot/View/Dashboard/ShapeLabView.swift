// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ShapeLabView: View {
    @EnvironmentObject var entitySelectionState: EntitySelectionState
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var shapeLab: ShapeLab

    @State private var selectedEdge: String?
    @State private var selectedPath: String?
    @State private var selectedRegion: String?

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var showDuplicateAlert = false
    @State private var duplicateCategoryIndex = 0

    func uniformVertexCount() -> Int {
        guard let selected = gameController.selectionIsUniform(), selected.first! is Vertex else {
            return 0
        }

        return selected.count
    }

    var body: some View {
        HStack(spacing: 40) {
            VStack(alignment: .leading) {
                Button("Create Open Edge") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedEdge = shapeLab.newShape(.edge, vertices, true)
                }
                .disabled(uniformVertexCount() < 2)

                Button("Create Closed Edge") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedEdge = shapeLab.newShape(.edge, vertices, false)
                }
                .disabled(uniformVertexCount() < 3)

                Button("Create Open Path") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedPath = shapeLab.newShape(.path, vertices, true)
                }
                .disabled(uniformVertexCount() < 2)

                Button("Create Closed Path") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedPath = shapeLab.newShape(.path, vertices, false)
                }
                .disabled(uniformVertexCount() < 3)

                Button("Create Circlular Region") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedRegion = shapeLab.newShape(.region, vertices, false)
                }
                .disabled(uniformVertexCount() != 2)

                Button("Create Rectangular Region") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedRegion = shapeLab.newShape(.region, vertices, false)
                }
                .disabled(uniformVertexCount() != 2)

                Button("Create Polygonal Region") {
                    let vertices = Utility.forceCast(gameController.getSelected(), to: Set<Vertex>.self)
                    selectedRegion = shapeLab.newShape(.region, vertices, false)
                }
                .disabled(uniformVertexCount() < 3)
            }

            VStack {
                Group {
                    if selectedEdge == nil {
                        Text("No Edges Created")
                            .background(Color(NSColor.tertiarySystemFill))
                            .padding()
                            .border(Color(NSColor.quaternarySystemFill), width: 2)
                    } else {
                        ShapeListView(
                            selection: $selectedEdge, whichSet: .edge, labelFrame: 100
                        )
                    }
                }
                .frame(height: 40, alignment: .center)

                Group {
                    if selectedPath == nil {
                        Text("No Paths Created")
                            .background(Color(NSColor.tertiarySystemFill))
                            .padding()
                            .border(Color(NSColor.quaternarySystemFill), width: 2)
                    } else {
                        ShapeListView(
                            selection: $selectedPath, whichSet: .path, labelFrame: 100
                        )
                    }
                }
                .frame(height: 40, alignment: .center)

                Group {
                    if selectedRegion == nil {
                        Text("No Regions Created")
                            .background(Color(NSColor.tertiarySystemFill))
                            .padding()
                            .border(Color(NSColor.quaternarySystemFill), width: 2)
                    } else {
                        ShapeListView(
                            selection: $selectedRegion, whichSet: .region, labelFrame: 100
                        )
                    }
                }
                .frame(height: 40, alignment: .center)
            }
            .frame(width: 505, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    ShapeLabView()
        .environmentObject(EntitySelectionState())
        .environmentObject(GameController())
        .environmentObject(ShapeLab())
}
