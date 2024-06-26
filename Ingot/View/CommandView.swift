// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var physicsFieldType: PhysicsFieldType = .drag

    var body: some View {
        VStack {
            Text("Command")
                .underline()
                .padding(.bottom)

            HStack {
                Picker("Click to Place", selection: $playgroundState.clickToPlace) {
                    ForEach(ClickToPlace.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }

                switch playgroundState.clickToPlace {
                case .field:
                    Picker("Field Type", selection: $physicsFieldType) {
                        ForEach(PhysicsFieldType.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }

                case .gremlin:
                    Picker("", selection: $playgroundState.selectedGremlinTexture) {
                        ForEach(playgroundState.gremlinImageNames, id: \.self) { imageName in
                            Image(imageName)
                        }
                    }

                    Image(playgroundState.selectedGremlinTexture)
                        .resizable()
                        .scaledToFit()

                case .joint:
                    EmptyView()
                case .vertex:
                    EmptyView()
                case .waypoint:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    CommandView()
        .environmentObject(PlaygroundState())
}
