# Dashboard

The Dashboard is the main SwiftUI element in the SKPlayground app window. It comprises three main sections:

- Playground Status Pane: keeps the user apprised of various aspects of the application status, such as the current
mouse position, or the current size of the game scene.

- Command Pane: contains various buttons, sliders, and toggles for controlling app-level operations, such as running
or pausing the physics simulation, or running actions 

- Configurator Pane: a dynamic view that changes depending in part on what is selected in the scene. For example, if a
physics drag field is selected, the Configurator Pane displays a set of status readouts and controls to allow the user
see and manipulate the state of that drag field. If a Gremlin is selected, the Configurator pane shows readouts and
controls to allow the user to see and manipulate the state of the Gremlin's physics body, as well as any actions,
physics fields, and physics joints attached to the Gremlin.

  
## Playground Status Pane

Currently this pane displays only the size of the playground area and the position of the mouse. I might update it to
include state from the various app components, especially those in the mouse input pipeline.

## Command Pane

- Dropdown: Set click mode, ie, what should happen when the user left-clicks in the playground: create a physics field,
a gremlin, a physics joint, or a vertex

- Dropdown: Secondary click mode for applicable primary modes.
  - When primary is set to gremlin, this dropdown lists the avatar images available for Gremlins 
  - When primary is set to physics field, this dropdown lists the types of field available
  - When primary is set to physics joint, this dropdown lists the types of joint available

- Run all actions
- Run actions on selected 
- Slider: scene actions speed
- Slider: scene physics speed
