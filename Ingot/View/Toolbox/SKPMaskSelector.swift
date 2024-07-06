// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct SKPMaskSelector<RelayObject: AnyObject>: View {
    @EnvironmentObject var gameController: GameController

    @Binding var selectedIndices: Set<Int>

    let fieldKeypath: ReferenceWritableKeyPath<RelayObject, UInt32>
    let label: Text
    let options: [String]

    init(
        _ selectedIndices: Binding<Set<Int>>,
        fieldKeypath: ReferenceWritableKeyPath<RelayObject, UInt32>,
        label: Text,
        options: [String]
    ) {
        self._selectedIndices = selectedIndices
        self.fieldKeypath = fieldKeypath
        self.label = label
        self.options = options
    }

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
        .onChange(of: selectedIndices) { _, newValue in
            let mask = Utility.makeBitmask(newValue)
            gameController.updateSelectedRelayTarget(whichField: fieldKeypath, newValue: mask)
        }
    }
}

#Preview {
    @State var selectedIndices = Set<Int>()
    return SKPMaskSelector<SKPhysicsBody>(
        $selectedIndices, fieldKeypath: \.fieldBitMask, label: Text("Some text"), options: []
    )
}
