#  Vertices and Regions

A *Vertex* is one of the Game Entities in the SKPlayground application. Its purpose
is to serve as one of the vertices of a *Region*, which defines the effective area
of a SpriteKit physics field. The following is a description of the user workflow for
creating and managing vertices and regions.

1. User selects *Vertex* from the "Click to Create" dropdown menu in the Dashboard.
2. User clicks in the Playground.
    1. A Vertex Game Entity is created and selected
    2. A VertexSprite representing the Vertex is created at the location of the click
    3. A HaloSprite appears over the Vertex to indicate selection; the HaloSprite
    is green indicating that it is the first Vertex selected
    4. The Vertices And Regions View, appears in the Dashboard. The View contains a
    horizontal scroller populated by icons that each represent a selected Vertex in
    the Playground; in this case, only the one selected Vertex is represented in the scroller.
3. User clicks elsewhere in the Playground.
    1. The selected Vertex is deselected.
    2. A Vertex Game Entity is created and selected
    3. A VertexSprite representing the Vertex is created at the location of the click
    4. A HaloSprite appears over the Vertex to indicate selection; the HaloSprite
    is green indicating that it is the first Vertex selected
    5. The scroller in the Vertices And Regions View is updated to reflect the currently
    selected Vertex
4. Step 3 and its substeps are repeated indefinitely
5. User shift-clicks one of the not-selected Vertices
    1. The clicked Vertex is selected; now there are multiple Vertices selected
    2. A HaloSprite appears over the clicked Vertex to indicate selection; the
    HaloSprite is red, indicating that it is the last Vertex selected.
    3. A blue line is drawn from the edge of the green HaloSprite to the red HaloSprite.
    4. In the scroller, an icon is added at the end of the array to represent the newly
    selected Vertex
    5. The "Create Region" button in the Vertices And Regions View is enabled
6. User shift-clicks one of the not-selected Vertices
    1. The clicked Vertex is selected; now there are multiple Vertices selected
    2. The red HaloSprite changes to blue, to indicate that its associated Vertex is
    a centrally selected Vertex
    3. A HaloSprite appears over the clicked Vertex to indicate selection; the
    HaloSprite is red, indicating that it is the last Vertex selected.
    4. A blue line is drawn from the edge of the blue HaloSprite to the edge of the red HaloSprite
    5. In the scroller, an icon is added at the end of the array to represent the newly
    selected Vertex
7. Step 6 and its substeps are repeated indefinitely
8a. User drag-and-drops icons in the scroller
    1. On drop, the icon is repositioned in the array
    2. On drop, the blue lines among the HaloSprites are redrawn to reflect the new array order
8b. User shift-clicks on a selected Vertex
    1. The Vertex is deselected
    2. The HaloSprite disappears
    3. The HaloSprites and lines among the remaining selected Vertices are recolored and redrawn
    to reflect the new state
    4. The icon in the scroller is removed
9. User clicks "Create Region"
    1. A representation of the region is stored in the app, with the name "New Region"
    2. The new region's name is added to the bottom of the *Regions* dropdown
10. User clicks "Rename" button
    1. Input field allows user to save the new name for the region
