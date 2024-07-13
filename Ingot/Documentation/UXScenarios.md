#  Scenarios

This document describes the user workflow scenarios available in SKPlayground.

## Place Game Entity in Scene

The *Click to Place* picker in the *Commands* pane has the following options:
Field, Gremlin, Joint, and Vertex. This section describes workflows
that start with the user choosing one of these options in the picker.

1. *Field*
    1. Dashboard shows *Field Type* picker; user chooses a field type
    1. Dashboard shows field config pane; user sets up config
    1. User clicks in scene; app creates the field
1. *Gremlin*
    1. Dashboard shows *Gremlin Avatar* picker; user chooses an avatar
    1. Dashboard shows gremlin config pane; user sets up config
    1. User clicks in scene; app creates the gremlin
1. *Joint*
    1. Dashboard shows *Joint Type* picker; user chooses a joint type
    1. Dashboard shows joint config pane; user sets up config
    1. In the joint config pane there are two buttons: *Set Body A* and *Set Body B*.
    The user clicks the first one, and the app indicates that the user should now
    click *Body A* for the joint. User clicks the desired entity or the background,
    then repeats for *Body B*.
    1. When both bodies are set, a message appears, "Click in scene to place joint".
    User clicks, and the joint is created.
1. *Vertex*
    1. Dashboard shows message, "Click in scene to place vertex"
    1. User clicks, app creates vertex
1. *Waypoint*
    1. Dashboard shows message, "Click in scene to place waypoint"
    1. User clicks, app creates waypoint
        
## Interact with Game Entity in Scene

All game entities may be selected individually or severally. Where possible, operations
are performed on all selected entities; some operations may be disabled when multiple
selection causes them not to make sense, for example, setting physics properties when
both a physics-enabled entity and a non-physics-enabled entity are selected.

Dragging is always available for selected entities. When the user drags one selected
entity, all selected entities are moved by the same offset as the one being dragged.
If the user begins to drag an entity that is not currently selected, that entity is
automatically selected; the shift key determines whether other entities are deselected.

The basics of mouse clicking work in the same fashion as most other mouse-driven apps

- Simple click on an entity selects that entity and deselects all others
- Shift-click selects the entity without deselecting others
- Right-click opens a context menu
  - Right-click on an entity selects that entity, deselecting all others before showing the context menu. Context menu
  options apply to the right-clicked entity
  - Right-click on the background deselects all entities before showing the context menu
- A handle appears on a selected entity, indicating the mouse-driven operations that
are available, such as dragging, rotating, and scaling, depending on how the handle is
dragged

### Context Menus

Right-clicking on some entities will produce a context menu. For a Gremlin, the context menu includes
the following options.

*Create Path*

The *Create Path* option allows the user to create a path of waypoints to be packaged into a follow-path action to be
added to the actions already assigned to the Gremlin. When the user selects this option from the context menu, the
Gremlin's selection halo changes color to indicate that subsequent clicks in the scene will create waypoints and add
them to a path. The user may click in the background to create a waypoint at the location of the click, or click an
existing waypoint to add it to the path. As the user adds waypoints to the path, a line is drawn from the previous
waypoint to the new waypoint, so the user can see the whole path as it develops. The user indicates the completion of
the path by one of the following:

- Right-click the Gremlin to which the path will be assigned and choose "Assign Closed Path", or double-click said
Gremlin. The present position of
the Gremlin is added as a final waypoint in the path and an action is created. The Gremlin remains selected; the
selection halo returns to normal to indicate that no workflows are in progress. The lines that indicate the path the
Gremlin will follow change color to indicate that the path and the action are complete. The *Paths* pane in the
Dashboard is activated, showing the auto-generated name of the new path in a dropdown menu, with a "Rename" button
alongside to allow the user to assign a new name to the path.

- Right-click the final waypoint in the path and choose "Assign Open Path", or double-click said waypoint. Identical to
the above operation, except that the path remains open; that is, the Gremlin's present position is not added to the
path.

- Right-click anywhere in the background and choose "Assign Closed Path" or "Assign Open Path". A closed or open path
is created as though the user had performed one of the above right-click or double-click operations.

*Attach Field*

The *Attach Field* option allows the user to create a physics field and attach it to the selected Gremlin. When the
user clicks the *Attach Field* option, a submenu appears, allowing the user to select the type of physics field: drag,
magnetic, electrical, etc. When the type is selected, the field is created and attached to the Gremlin. The Physics
Field Configurator pane is activated in the Dashboard, with controls specific to the type of Field that has been
created, as well as a horizontal scroller showing all the fields that are attached to the Gremlin. The new Field is
selected in the scroller. The user can select other fields in the scroller and manipulate their settings with the
controls in the Configurator pane. Fields can also be deleted, by selecting them in the scroller and clicking the
"Delete Field" button in the Configurator pane.

*Attach Joint*

The *Attach Joint* option allows the user to create a physics joint and attach it to the selected Gremlin as "body A"
in SpriteKit parlance. When the user clicks the *Attach Joint* option, a submenu appears, allowing the suer to select
the type of joint: fixed, spring, etc. Then the type is selected, the Gremlin's selection halo changes to indicate that
further user input is required to complete the joint creation. The Physics Joint Configurator pane is activated in the
Dashboard, with controls specific to the type of Joint being created. A message appears in the Configurator pane,
prompting the user to click "body B" for the joint. The user can click either the background, to assign the scene's
physics body as "body B", or another Gremlin, to assign that Gremlin as "body B". When the user clicks, a new indicator
appears at the point of the click in the scene. The Configurator pane is updated with a message prompting the user to
drag this new indicator to a desired location; the user can drag the indicator or leave it where it is, then click
"Create Field" in the Configurator pane.  

*Assign Space Actions*

The *Assign Space Actions* option allows the user to create simple move, rotate, and scale actions against the
Gremlin. When the user selects *Assign Space Actions*, the Gremlin's selection halo changes to indicate that the user
can drag it around with the main selection halo, or rotate/scale it with the halo subhandles. The Space Actions
Configurator pane appears in the Dashboard, with a button titled "Click to Create Actions". When finished
dragging the Gremlin around, the user clicks this button and action(s) are created that correspond to the user's
operations on the Gremlin. The new actions appear in the actions scroll view in the Configurator pane. The user can
select actions in the scroller individually to manipulate their settings. 

Non-mouse-driven operations are made available in the Dashboard depending on what is
selected. The following Dashboard behavior applies when a single entity of the indicated
type is selected.

1. *Field*: The Dashboard displays the field configuration pane, allowing the user to
set various field attributes such as strength and falloff. A dropdown entitled "Set Region"
is available on the pane, allowing the user to set the field's region based on a previously
created set of vertices -- see *Vertex* below.
1. *Gremlin*: The Dashboard displays the gremlin configuration pane,
allowing the user to set various gremlin attributes such as opacity and action speed. The
scale, rotation, and position attributes of a gremlin are controlled by using the selection
handles mentioned above. The *Actions* pane, described elsewhere in this document, is also
displayed.
1. *Joint*: The Dashboard displays the joint configuration pane, allowing the user to set
various joint attributes such as movement limits. Joint attributes are specific to the
type of joint, as described elsewhere in this document.
1. *Vertex*: The Dashboard displays all the user-defined regions that include the vertex.
Region definition is described elsewhere in this document.

## Actions

### Create and Configure Individual Action

When a gremlin entity is selected, the Dashboard displays the *Actions* pane. This pane
shows all the actions that have been previously assigned to the gremlin, allowing the
user to edit them, reorder them, and create sequence or group subsets from them. The pane
also allows the user to create new actions to be assigned to the gremlin, on the *Space*
and *Physics* tab. Note that multiple selection, even multiple selection of only gremlins,
disables the *Actions* pane, that is, the user can operate on only one gremlin at a
time.

#### Space

The *Space* tab allows the user to create space-oriented actions such as movement,
rotation, and scaling. A slider allows the user to set the duration. When the tab
appears, a button titled "Click to Start" is available. When the user clicks this
button, a special handle appears on the gremlin in the scene to indicate that the
space-oriented actions are driven by mouse input to the handle; the "Click to Start"
button changes to "Click to Create Action" and a "Cancel" button. "Cancel" works
as one might expect, cancelling the action creation operation. "Click to Create
Action" creates the action(s) necessary to move, rotate, and scale the gremlin as
indicated by the user's operations on the special handle. New actions are added to
the scroll view.

#### Physics

The *Physics* tab allows the user to create physics-oriented actions such as
applying a vector force or torque to the gremlin's physics body. Creation and
configuration of physics actions are done in the Dashboard, that is, they are not
mouse-driven like space actions. A button entitled "Click to Create Action" is
present. No "Cancel" button is necessary. The user may simply abandon a physics
action by simply refraining from clicking the "Click to Create Action" button.

### Create and Configure Action Sets

The scroll view allows the user to select actions individually or severally. When
multiple actions are selected in the scroll view, two buttons appear below the scroller,
entitled "Create Group" and "Create Sequence". When the user clicks one of these, the
selected actions are packaged into an actions group or sequence, such that when the
actions are run, they will run concurrently or serially, respectively.
            
        SKNode: speed, pause, alpha, scale, rotation, position
