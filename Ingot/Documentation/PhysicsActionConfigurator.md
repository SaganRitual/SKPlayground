#  Physics Actions

SpriteKit Playground allows the user to create SpriteKit's SKActions and assign them to Gremlins, which are the
primary game entity. On the right-hand side of the application window at the bottom of the main Dashboard view, is
the Physics Actions Configurator View. Contained in this View are:

- A dropdown menu to allow the user to select the
type of action to create: force, impulse, torque, or angular impulse. Currently these are the only physics actions
available.

- A button next to the dropdown, titled "Create New"

- A Text view indicating the type of action currently selected, or an empty view if no actions have yet been
created for the Gremlin

- A set of sliders to control the duration, repeat count, and parameters specific to the action selected in the
dropdown, or
a blank area if no actions have yet been created for the Gremlin
 
- A horizontal scroll view that shows each action assigned to the Gremlin as a rectangle displaying the parameters
that are assigned to the action.

## Workflow

Before any actions are created for a Gremlin, the scroll view displays a message like "No actions created yet". When
actions have been created, it is always true that one of the actions is "selected". This means that the actions's
view in the scroll view is highlighted in some way (let's say the rectangle is outlined in yellow), the Text view
below the dropdown menu indicates the type of the selected action, and sliders appear to control the parameters of that
action. The user workflow is as follows 

1. The user chooses the desired physics action type from the dropdown and clicks "Create New"
1. A new action is created with default values (mostly zeros)
1. The text view appears, indicating the type of action, sliders for the action appear, and the action's view appears
in the scroll view, selected, as described above
1. The user manipulates the sliders as desired; as the sliders change the action parameters, the action's view in
the scroller are also updated
1. After creating multiple actions, the user can drag and drop the action views in the scroller to reorder them,
which sets the order in which the actions are run when they are finally run
1. The user can shift-click actions to multi-select adjacent actions; if the user shift-clicks a non-adjacent action,
that action and everything between it and the last selected action is added to the selection 
1. When more than one action is selected, a new button appears above the scroller, titled "Make Group"
1. When the user clicks "Make Group", the actions are visually highlighted as a group, with a blue outline containing
all of them; the sliders for individual actions disappear, replaced by a single duration slider that sets the
duration of the group action, and a repeat count slider that sets the repeat count for the entire group
1. When a group is selected, a new button titled "Ungroup" appears; clicking this will ungroup the selected group
into individual actions; highlighting is updated accordingly
1. Making a group will cause the actions in the group to run simultaneously, that is, in parallel, as opposed to
serially
