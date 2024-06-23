// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ContentView: View {
    var body: some View {
        ActionTokensScrollView()
            .environmentObject({ let ps = PlaygroundState(); ps.makeTestTokensArray(); return ps }())
    }
}

#Preview {
    ContentView()
}
