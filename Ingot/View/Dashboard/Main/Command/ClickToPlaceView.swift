// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ClickToPlaceView: View {
    @ObservedObject var workflowRelay: WorkflowRelay

    @State private var pickerHeight = 0.0

    let titleTextWidth = 120.0

    var body: some View {
        VStack {
            HStack {
                Text("Click to Place")
                    .frame(width: titleTextWidth, alignment: .leading)

                Picker("", selection: $workflowRelay.clickToPlace) {
                    ForEach(WorkflowManager.ClickToPlace.allCases) { option in
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

            switch workflowRelay.clickToPlace {
            case .field:
                HStack {
                    Text("Field Type")
                        .frame(width: titleTextWidth, alignment: .leading)

                    Picker("", selection: $workflowRelay.fieldType) {
                        ForEach(PhysicsFieldType.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                }

            case .gremlin:
                HStack {
                    Text("Sprite")
                        .frame(width: titleTextWidth, alignment: .leading)

                    Picker("", selection: $workflowRelay.avatarName) {
                        ForEach(ContextMenuManager.avatarNames, id: \.self) { imageName in
                            Image(imageName)
                        }
                    }
                }

            case .joint:
                HStack {
                    Text("Joint Type")
                        .frame(width: titleTextWidth, alignment: .leading)

                    Picker("", selection: $workflowRelay.jointType) {
                        ForEach(PhysicsJointType.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                }

            default:
                Text("")
                    .frame(height: pickerHeight)
            }
        }
        .padding([.bottom, .horizontal])
    }
}
