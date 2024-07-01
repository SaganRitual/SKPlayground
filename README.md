#  SKPlayground

A tool for experimenting with SpriteKit

- Create sprites, move them around, scale and rotate
- Create and run actions to move, scale, rotate, follow paths
- Create and run physics actions
- Create vertices, move them around
- Create phsyics edges, movement paths, physics field regions from groups of vertices
- Configure physics world: gravity, physics speed
- Configure physics body per-sprite: mass, restitution, etc

That kind of stuff in general. Will be adding the following soon:

- Create and configure physics fields, move them around, attach them to sprites
- Create and configure physics joints, move them around, attach them to sprites

It's probably a bit fragile and more than a bit buggy. Here's some stuff that is working:

## Place, move, scale, rotate sprites

Selection works like you would expect: click to select, shift-click to multiselect, or
drag a rubber band around the ones you want selected. Drag them around, scale and rotate
with the colored handles (I changed the way they attach to the scene and broke the scaling
a little; they're supposed to track with the mouse). Choose which sprite you want to place
in the dropdown menu on the right.

## Place and move vertices, create paths, assign follow-path actions

Choose "Vertices" in the dropdown menu, click in the playground. A vertex is created. To make
a path, create all your vertices, then select the first one, then shift-select the rest of
them in the order you want. Then in the Shape Lab tab, click "Create Closed Path", name the
path if you want to. Choose "Gremlin" in the dropdown, choose your sprite, place the sprite
in the playground. Go to the Actions -> Space Actions tab, set a duration, create a follow action.
Finally, click "Run Actions" 

## Assign move, scale, rotate actions

Choose "Gremlin", choose your sprite, click in the playground. Go to Actions -> Space Actions and
click "Start". The sprite halo will turn orange. Drag the sprite around, rotate and resize,
set a duration, click "Create Action". The sprite will go back home and turn green. Click "Run Actions"
and the actions run.

## Assign physics actions

Same as above but go to Actions -> Physics Actions. Set up the action you want with the sliders, set
the duration, click "Create Action". Then "Run Actions" will run the physics actions

## Change physics world and gremlin physics body settings

See the Physics Tab
