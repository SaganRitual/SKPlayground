// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct SKPToggle<T: AnyObject>: View {
    @EnvironmentObject var gameController: GameController

    @Binding var isOn: Bool

    let fieldKeypath: ReferenceWritableKeyPath<T, Bool>
    let title: String

    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
        .toggleStyle(.checkbox)
        .onChange(of: isOn) {
            gameController.updateSelectedRelayTarget(whichField: fieldKeypath, newValue: isOn)
        }
    }
}
