// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct CommandView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    @State private var physicsFieldType: PhysicsFieldType = .drag
    @State private var pickerHeight = 0.0

    let titleTextWidth = 120.0

    var body: some View {
        VStack {
            Text("Command")
                .underline()
                .padding(.bottom)

            VStack {
                HStack {
                    Text("Click to Place")
                        .frame(width: titleTextWidth, alignment: .leading)

                    Picker("", selection: $playgroundState.clickToPlace) {
                        ForEach(ClickToPlace.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .overlay(
                        GeometryReader { gr in
                            Color.clear
                                .onAppear {
                                    pickerHeight = gr.size.height
                                }
                        }
                    )
                }

                switch playgroundState.clickToPlace {
                case .field:
                    HStack {
                        Text("Field Type")
                            .frame(width: titleTextWidth, alignment: .leading)

                        Picker("", selection: $physicsFieldType) {
                            ForEach(PhysicsFieldType.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    }

                case .gremlin:
                    HStack {
                        Text("Sprite")
                            .frame(width: titleTextWidth, alignment: .leading)

                        Picker("", selection: $playgroundState.selectedGremlinTexture) {
                            ForEach(playgroundState.gremlinImageNames, id: \.self) { imageName in
                                Image(imageName)
                            }
                        }
                    }

                default:
                    Text("")
                        .frame(height: pickerHeight)
                }
            }
        }
    }
}


#Preview {
    CommandView()
        .environmentObject(PlaygroundState())
}
