// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI

struct ActionTokensScrollView: View {
    @EnvironmentObject var playgroundState: PlaygroundState

    func createActionView(for container: ActionTokenContainer) -> any View {
        switch container.token {
        case let angularImpulseToken as AngularImpulseActionToken:
            return AngularImpulseActionTokenView(duration: angularImpulseToken.duration, angularImpulse: angularImpulseToken.angularImpulse)

        case let forceToken as ForceActionToken:
            return ForceActionTokenView(duration: forceToken.duration, focus: forceToken.focus, force: forceToken.force)

        case let impulseToken as ImpulseActionToken:
            return ImpulseActionTokenView(duration: impulseToken.duration, focus: impulseToken.focus, impulse: impulseToken.impulse)

        case let moveToken as MoveActionToken:
            return MoveActionTokenView(duration: moveToken.duration, targetPosition: moveToken.targetPosition)

        case let rotateToken as RotateActionToken:
            return RotateActionTokenView(duration: rotateToken.duration, targetRotation: rotateToken.targetRotation)

        case let scaleToken as ScaleActionToken:
            return ScaleActionTokenView(duration: scaleToken.duration, targetScale: scaleToken.targetScale)

        case let torquen as TorqueActionToken:
            return TorqueActionTokenView(duration: torquen.duration, torque: torquen.torque)

        default:
            fatalError()
        }
    }

    var body: some View {
        Group {
            if playgroundState.activeActionTokens.isEmpty {
                Text("No actions assigned to this entity")
                    .padding()
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(playgroundState.activeActionTokens) { container in
                            AnyView(createActionView(for: container))
                        }
                    }
                }
                .padding()
            }
        }
        .background(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15), style: .circular).fill(Color(.controlBackgroundColor)))
        .frame(height: 350)
    }
}

#Preview {
    let ps = PlaygroundState()
    ps.makeTestTokensArray()

    return ActionTokensScrollView()
        .environmentObject(ps)
}
