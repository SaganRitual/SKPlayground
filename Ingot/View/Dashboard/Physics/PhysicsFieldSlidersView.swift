// We are a way for the cosmos to know itself. -- C. Sagan

import SpriteKit
import SwiftUI

struct PhysicsFieldSlidersView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var physicsFieldState: PhysicsFieldState
    @EnvironmentObject var physicsMaskCategories: PhysicsMaskCategories

    @Binding var setGravity: Bool

    @State private var enableRegion = false
    @State private var selectedCategoryIndices = Set<Int>()
    @State private var selectedRegion: String?
    @State private var regionPair = ABPair(a: 0, b: 0)

    init(setGravity: Binding<Bool>) {
        _selectedRegion = State(initialValue: noRegionString)
        _setGravity = setGravity
    }

    func makeScalarView(_ value: CGFloat) -> some View {
        Text(String(format: "%.1f", value))
    }

    var regionToggle: some View {
        Toggle(isOn: $enableRegion) {
            Text("Region")
        }
        .toggleStyle(.checkbox)
    }

    let noRegionString = "No region selected - field is infinite"
    let widthSlider = 500.0

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                BasicScalarSlider(
                    scalar: $physicsFieldState.falloff,
                    scalarView: Text(String(format: "%.2f", physicsFieldState.falloff)),
                    title: Text("Falloff"),
                    minLabel: "-2", maxLabel: "10", range: -2...10, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsFieldState.falloff) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }
                    
                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)
                    
                    fieldNode.falloff = Float(physicsFieldState.falloff)
                }
                
                BasicScalarSlider(
                    scalar: $physicsFieldState.minimumRadius,
                    scalarView: Text(String(format: "%.2f", physicsFieldState.minimumRadius)),
                    title: VStack(alignment: .leading) { Text("Minimum"); Text("Radius") },
                    minLabel: "0", maxLabel: "100", range: 0...100, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsFieldState.minimumRadius) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }
                    
                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)
                    
                    fieldNode.minimumRadius = Float(physicsFieldState.minimumRadius)
                }
                
                BasicScalarSlider(
                    scalar: $physicsFieldState.smoothness,
                    scalarView: Text(String(format: "%.2f", physicsFieldState.smoothness)),
                    title: Text("Smoothness"),
                    minLabel: "-2", maxLabel: "10", range: -2...10, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsFieldState.smoothness) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }
                    
                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)
                    
                    fieldNode.smoothness = Float(physicsFieldState.smoothness)
                }
                
                BasicScalarSlider(
                    scalar: $physicsFieldState.strength,
                    scalarView: Text(String(format: "%.2f", physicsFieldState.strength)),
                    title: Text("Strength"),
                    minLabel: "-2", maxLabel: "100", range: -2...100, widthSlider: widthSlider
                )
                .padding(.top)
                .onChange(of: physicsFieldState.strength) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }
                    
                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)
                    
                    fieldNode.strength = Float(physicsFieldState.strength)
                }
                
                if physicsFieldState.fieldType == .noise || physicsFieldState.fieldType == .turbulence {
                    BasicScalarSlider(
                        scalar: $physicsFieldState.animationSpeed,
                        scalarView: Text(String(format: "%.2f", physicsFieldState.animationSpeed)),
                        title: VStack(alignment: .leading) {
                            Text("Animation").font(.system(size: 10))
                            Text("Speed").font(.system(size: 10))
                        },
                        minLabel: "-2", maxLabel: "2", range: -2...2, widthSlider: widthSlider
                    )
                    .padding(.top)
                    .onChange(of: physicsFieldState.animationSpeed) {
                        guard gameController.entitySelectionState.selectionState == .one else { return }
                        guard let fieldEntity = gameController.getSelected().first as? Field else { return }
                        
                        let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                        let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)
                        
                        fieldNode.animationSpeed = Float(physicsFieldState.animationSpeed)
                    }
                }
            }
            
            VStack(spacing: 0) {
                ShapeListView(
                    selection: $selectedRegion, whichSet: .region, labelFrame: 100,
                    readOnly: true, readOnlyNullSelection: noRegionString
                )
                .padding(.top)
                
                CheckboxPicker(
                    selectedIndices: $selectedCategoryIndices,
                    label: Text("Set Categories"),
                    options: physicsMaskCategories.names
                )
                .padding(.top)
                .onChange(of: selectedCategoryIndices) {
                    guard gameController.entitySelectionState.selectionState == .one else { return }
                    guard let fieldEntity = gameController.getSelected().first as? Field else { return }
                    
                    let fieldNode_ = fieldEntity.face.rootSceneNode.children.first(where: { $0 is SKFieldNode })
                    let fieldNode = Utility.forceCast(fieldNode_, to: SKFieldNode.self)
                    
                    fieldNode.categoryBitMask = Utility.makeBitmask(selectedCategoryIndices)
                }
            }
        }
    }
}

#Preview {
    @State var setGravity = false
    return PhysicsFieldSlidersView(setGravity: $setGravity)
}
