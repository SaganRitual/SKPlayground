#  Fields

A *Field* is a game entity that controls an associated SpriteKit
physics field. All physics field types are supported except the
customField. The following is a description of the user workflow for
creating and managing fields. 

1. User selects "Field" from the "Click to Create" dropdown in the
control panel
2. User selects the field type from the "Field Type" dropdown in
the control panel
3. User clicks in the playground area
    1. A Field game entity is created and selected
    2. A FieldSprite representing the Feild is created at the location of the click
    3. A HaloSprite appears over the FieldSprite to indicate selection; the HaloSprite
    is orange, indicating that the Field is not yet incorporated into the physics world
    4. The field configuration tab appears in the configuration section of the control panel
    5. User configures the field
    6. User clicks either "Attach Field to World" or "Attach Field to Gremlin"
    6a. If "World" then a SpriteKit physics field is created at the location of the sprite
    and attached to the physics world. The FieldSprite's halo changes to green. At this point
    the FieldSprite may be dragged anywhere in the playground; the physics field will move with it
    6b. If "Gremlin" then a message appears instructing the user to click the desired
    Gremlin. When the Gremlin is clicked, a SpriteKit physics field is created and attached
    to the Gremlin. The FieldSprite is shrunk and visually attached to the selected Gremlin. The
    field will move with the Gremlin.
4. The field may be reassigned to a different Gremlin or to the world:
    1. If the field is currently attached to the physics world, the user will click on the FieldSprite to select it.
    If instead it is currently attached to a Gremlin, the user will click on the Gremlin.
    2a. If the field is currently attached to a Gremlin, two new buttons appear in the configuration pane:
    "Reassign to World" and "Reassign to Other Gremlin". Clicking the first will detach the field from its current
    Gremlin and attach it to the world at the location of the Gremlin. A new FieldSprite will appear behind the Gremlin,
    selected with a green halo.
    2b. If the field is currently attached to the world, only one button will appear in the configuration pane,
    "Reassign to Gremlin". Clicking this will change the Gremlin's selection halo to orange, indicating that the
    user must take action. A message appears in the configuration pane, "Click The New Gremlin". When the user clicks
    the new Gremlin, the field will be attached to that Gremlin. 
