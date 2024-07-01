// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CheckboxPicker: View {
    @Binding var selectedIndices: Set<Int>

    let label: Text
    let options: [String]

    var body: some View {
        Menu {
            ForEach(options.indices, id: \.self) { index in
                Button(
                    action: {
                        if selectedIndices.contains(index) {
                            selectedIndices.remove(index)
                        } else {
                            selectedIndices.insert(index)
                        }
                    },
                    label: {
                        HStack {
                            Image(systemName: selectedIndices.contains(index) ? "checkmark.square.fill" : "square")
                            Text(options[index])
                        }
                    }
                )
            }
        } label: {
            label
        }
    }
}

#Preview {
    CheckboxPicker(selectedIndices: .constant(Set<Int>()), label: Text("Some text"), options: [])
}
