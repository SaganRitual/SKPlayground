// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

protocol ActionTokenViewProtocol: View {
    var duration: Double { get }
}

struct ActionTokenStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(.black))
            .padding(2)
            .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(.white))
    }
}

extension View {
    func actionTokenStyle() -> some View {
        modifier(ActionTokenStyle())
    }
}
