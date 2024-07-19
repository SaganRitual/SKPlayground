// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ActionTokensScrollView: View {
    @ObservedObject var actionRelay: ActionRelay
    @ObservedObject var gameController: GameController

    func createActionView(for token: ActionToken) -> any View {
        let selected = gameController.selectedAction === token

        switch token {
        case let angularImpulseToken as AngularImpulseActionToken:
            return AngularImpulseActionTokenView(angularImpulseToken, selected: selected)

//        case let followPathToken as FollowPathActionToken:
//            return FollowPathActionTokenView(followPathToken, selected: selected)

        case let forceToken as ForceActionToken:
            return ForceActionTokenView(forceToken, selected: selected)

        case let impulseToken as ImpulseActionToken:
            return ImpulseActionTokenView(impulseToken, selected: selected)

//        case let moveToken as MoveActionToken:
//            return MoveActionTokenView(
//                duration: moveToken.duration, 
//                targetPosition: moveToken.targetPosition,
//                selected: gameController.selectedAction === token
//            )
//
//        case let rotateToken as RotateActionToken:
//            return RotateActionTokenView(
//                duration: rotateToken.duration, 
//                targetRotation: rotateToken.targetRotation,
//                selected: gameController.selectedAction === token
//            )
//
//        case let scaleToken as ScaleActionToken:
//            return ScaleActionTokenView(
//                duration: scaleToken.duration, 
//                targetScale: scaleToken.targetScale,
//                selected: gameController.selectedAction === token
//            )

        case let torquen as TorqueActionToken:
            return TorqueActionTokenView(torquen, selected: selected)

        default:
            fatalError()
        }
    }

    var body: some View {
        Group {
            if let gremlin = gameController.singleSelected() as? Gremlin, !gremlin.actions.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(gremlin.actions) { token in
                            Button(action: {
                                gameController.selectedAction = token
                            }) {
                                AnyView(createActionView(for: token))
                            }
                        }
                    }
                }
            } else {
                Text("No actions assigned to this entity")
            }
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(Color(.controlBackgroundColor)
            )
        )
    }
}
