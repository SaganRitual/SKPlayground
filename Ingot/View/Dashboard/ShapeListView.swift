// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ShapeListView: View {
    @EnvironmentObject var shapeLab: ShapeLab

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var showDuplicateAlert = false
    @State private var duplicateNameIndex = 0

    @Binding var currentSelection: String?

    let whichSet: ShapeLab.WhichShape
    let labelFrameWidth: CGFloat?

    init(
        selection: Binding<String?>, whichSet: ShapeLab.WhichShape, labelFrame: CGFloat? = nil
    ) {
        self._currentSelection = selection
        self.whichSet = whichSet
        self.labelFrameWidth = labelFrame
    }

    var theSet: [UserShape] {
        switch whichSet {
        case .edge:
            shapeLab.edges
        case .path:
            shapeLab.paths
        case .region:
            shapeLab.regions
        }
    }

    var setName: String {
        switch whichSet {
        case .edge:
            "Edge"
        case .path:
            "Path"
        case .region:
            "Region"
        }
    }

    var articalized: String {
        switch whichSet {
        case .edge:
            "an edge"
        case .path:
            "a path"
        case .region:
            "a region"
        }
    }

    var body: some View {
        HStack {
            Picker(selection: $currentSelection) {
                ForEach(theSet) { shape in
                    Text(shape.name)
                        .tag(Optional(shape.name))
                }
            } label: {
                Text("\(setName)s")
                    .frame(width: labelFrameWidth, alignment: .leading)
            }
            .pickerStyle(.menu)

            Button("Rename") {
                editedName = currentSelection!
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
                        if let duplicateIx = shapeLab.renameShape(
                            whichSet, currentName: currentSelection!, newName: editedName
                        ) {
                            duplicateNameIndex = duplicateIx
                            showDuplicateAlert = true
                        } else {
                            currentSelection = editedName
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
            title: Text("\(setName) names must be unique"),
            message: Text("There is already \(articalized) called \(theSet[duplicateNameIndex].name)"),
            dismissButton: .cancel()
          )
        }
    }
}

#Preview {
    ShapeListView(selection: .constant(nil), whichSet: .edge)
}
