// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

protocol ActionTokenViewProtocol: View {
    var duration: Double { get }
}

struct ActionTokenStyle: ViewModifier {
    let selected: Bool

    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(.black))
            .padding(2)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular)
                    .fill(selected ? .yellow : .white)
            )
    }
}

extension View {
    func actionTokenStyle(_ selected: Bool = false) -> some View {
        modifier(ActionTokenStyle(selected: selected))
    }
}
