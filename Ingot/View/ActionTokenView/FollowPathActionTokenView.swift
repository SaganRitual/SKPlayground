// We are a way for the cosmos to know itself. -- C. Sagan

import SwiftUI


struct FollowPathActionTokenView: View, ActionTokenViewProtocol {
    @EnvironmentObject var shapeLab: ShapeLab

    let duration: Double
    let path: [CGPoint]?
    let pathId: UUID?

    init(duration: Double, path: [CGPoint]) {
        self.duration = duration
        self.path = path
        self.pathId = nil
    }

    init(duration: Double, pathId: UUID) {
        self.duration = duration
        self.path = nil
        self.pathId = pathId
    }

    var description: String {
        if pathId == nil {
            return "\(self.path!.first!)...\(self.path!.last!)"
        } else {
            return shapeLab.paths.first(where: { $0.uuid == pathId! })!.name
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("Follow path \(description)")
            Text(String(format: "t = %.1fs", duration))
        }
        .actionTokenStyle()
    }
}

#Preview {
    FollowPathActionTokenView(
        duration: .random(in: (1.0 / 60)..<100),
        path: (0..<5).map { _ in CGPoint.random(in: -100...100) }
    )
}
