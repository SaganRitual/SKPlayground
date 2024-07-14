// We are a way for the cosmos to know itself. -- C. Sagan

import Foundation
import SwiftUI

struct PlaygroundStatusView: View {
    let viewSize: CGSize
    let mousePosition: CGPoint

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("SpriteKit Playground")
                    .underline()
                Spacer()
            }
            .padding(.bottom)

            HStack {
                Text("Scene Size")
                Spacer()
                Text("\(viewSize)")
            }
            .padding(.bottom)

            HStack {
                Text("Mouse Position")
                Spacer()
                Text(Utility.positionString(mousePosition))
            }
        }
    }
}
