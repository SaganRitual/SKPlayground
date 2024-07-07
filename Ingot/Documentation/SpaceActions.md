#  Space-Oriented Actions

The user can create actions to be run against a game entity. Space-oriented
actions include movement from point to point, scaling, rotation, and path following. These actions
are non-physics based. There are several different mechanisms for creating
space-oriented actions.

## Point-to-Point, Rotate, Scale: Drag to Create

For these three primitive space-oriented actions, the user can select an entity and navigate to the Space Actions tab,
then click the button titled "Start Drag Operations", or right-click an entity and select "Create Space Actions" from
the resulting context menu, which selects the entity and deselects all others, then causes the Space Actions tab to
appear automatically. The selection halo for the entity changes color to indicate that dragging, rotating, and scaling
the entity will be recorded as actions. When finished with these manipulations, the user sets the desired duration with
the slider and clicks "Create Action(s) From Dragged Entity", and actions are created. The entity is returned to its
original position and the selection halo is restored to its normal state. The created actions appear in the scroll view
and can now be reordered, grouped, and individually edited.

## Path Following

The user can create follow-path actions in several different ways.

### Context Menu -> Create Path

The user right-clicks the target entity and a context menu appears. One of the options is "Create Path". When the user
selects this option, the mouse cursor changes to a waypoint flag symbol, to indicate that subsequent mouse clicks will
place waypoints in the path. The Space Actions tab is brought into view with a button titled "Create Action to Follow
Path". As waypoints are added, a line is drawn from the previous to the new waypoint, depicting the path to be followed.
The user can click in the background to create a waypoint, or click on an existing waypoint to add it to the path. When
finished setting waypoints, the user double-clicks the final waypoint in the path, or double-clicks the target entity
to indicate that the entity should return to its original position after following the path. The user then clicks the
"Create Action..." button, at which time the action is created and added to the scroll view along with any other
actions that have been created for the entity. Also, the path itself is saved in the app with a unique name that can
be referenced later when creating new follow actions. 

### Context Menu -> Select Path

The user right-clicks the target entity and a context menu appears. One of the options is "Select Path". If the user
has not yet created any paths, the option is disabled. If the user has created at least one path, the list of path
names appears as a submenu under the enabled "Select Path" option. When the user selects a path from the list, lines are
drawn among the waypoints of the path, allowing the user to ensure that this is the desired path. As with the "Create
Path" method, the Space Actions tab is brought into view with a button titled "Create Action to Follow Path". When 
satisfied that the selected path is the desired path, the user clicks the "Create Action..." button, at which time the
action is created in the same manner as for the "Create Path" method. 
