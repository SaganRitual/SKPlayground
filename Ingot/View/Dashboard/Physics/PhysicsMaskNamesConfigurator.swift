// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct PhysicsMaskNamesConfigurator: View {
    @ObservedObject var physicsMaskNamesManager: PhysicsMaskNamesManager

    @State private var currentMaskName = "Mask 0"
    @State private var duplicateCategoryIndex = 0
    @State private var editedName = ""
    @State private var isEditing = false
    @State private var showDuplicateAlert = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Picker("Mask Names", selection: $currentMaskName) {
                        ForEach(physicsMaskNamesManager.names, id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.menu)

                    Button("Rename") {
                        editedName = currentMaskName
                        isEditing = true
                    }
                }
                .padding(.top)
                .sheet(isPresented: $isEditing) { // Sheet for editing
                    VStack {
                        TextField("New Name", text: $editedName)
                            .padding()

                        HStack {
                            Button("Submit") {
                                if let duplicateIx = physicsMaskNamesManager.renameMask(
                                    currentName: currentMaskName, newName: editedName
                                ) {
                                    duplicateCategoryIndex = duplicateIx
                                    showDuplicateAlert = true
                                } else {
                                    currentMaskName = editedName
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
                        title: Text("Masks names must be unique"),
                        message: Text(
                            "There is already a mask called "
                            + "\(physicsMaskNamesManager.names[duplicateCategoryIndex])"
                        ),
                        dismissButton: .cancel()
                    )
                }
            }
        }
        .padding(.horizontal)
    }
}
