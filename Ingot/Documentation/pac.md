# Physics Actions Configurator

The Physics Actions Configurator empowers users to create and manipulate SpriteKit's SKActions, assigning them to Gremlins (the game's primary entities). Located at the bottom right of the Dashboard view, this tool offers a streamlined workflow for designing complex physical interactions.

## Key Features & Workflow

1. **Action Selection:**
   - A dropdown menu allows users to choose from available SKAction types (force, impulse, torque, angular impulse).
   - The "Create New" button generates a new action of the selected type with default parameters.
   - Consider adding a search or filter function to the dropdown if the list of actions grows significantly.

2. **Action Visualization & Control:**
   - A text view dynamically displays the type of the currently selected action.
   - Interactive sliders provide real-time control over action duration, repeat count, and other type-specific parameters.
   - Action parameters could be displayed directly within the scroll view (e.g., as text overlays on the action rectangles) for quicker reference.

3. **Action Sequencing:**
   - A horizontal scroll view visually represents each assigned action as a rectangle.
   - Users can drag and drop actions within the scroll view to reorder their execution sequence. 

4. **Group Actions:**
   - Shift-click allows for multi-selecting adjacent actions. (Consider adding a "Select All" option for convenience.)
   - The "Make Group" button combines selected actions into a parallel-executing group, visually highlighted by a blue outline.
   - Group duration and repeat count can be controlled with dedicated sliders.
   - An "Ungroup" button reverts grouped actions back to their individual states.
   - Implement visual cues (e.g., nesting or stacking) to indicate hierarchical relationships between individual and grouped actions.

## Additional Considerations

- **Presets:**  Introduce pre-defined action presets (e.g., "Bounce," "Spin," "Explode") to accelerate common scenarios.
- **Timeline View:**  Consider adding an optional timeline view for a more granular look at action timing and sequencing.
- **Custom Easing:** Allow users to customize the easing functions of actions for more nuanced movement.
- **Visual Feedback:** Provide visual cues in the main game view to reflect the active action(s) on a Gremlin. This could be a subtle glow, particle effect, or color change.

## Example Use Case

1. Select "Impulse" from the dropdown and click "Create New."
2. Adjust the impulse vector and duration sliders.
3. Repeat steps 1 & 2 to create a "Torque" action.
4. Drag and drop the actions in the scroll view to set the desired order.
5. (Optional) Shift-click both actions and click "Make Group" to have them execute simultaneously.
