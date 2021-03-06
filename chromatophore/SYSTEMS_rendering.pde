String RENDERING_SYSTEM = "RenderingSystem";

class RenderingSystem extends System {

  HashMap<Integer, ArrayList<ShapeComponent>> z_tracker;
  HashMap<ShapeComponent, Transform> transforms;

  RenderingSystem(World w) {
    super(RENDERING_SYSTEM, w);
    this.z_tracker = new HashMap<Integer, ArrayList<ShapeComponent>>();
    this.transforms = new HashMap<ShapeComponent, Transform>();
  }

  void drawDrawables() { 

    if (this.world.entity_manager.component_store.containsKey(SHAPE)) {

      // Clear arrays
      for (Integer key :  this.z_tracker.keySet()) {
        this.z_tracker.get(key).clear();
      }

      int min_z = 100000;
      int max_z = -100000;

      // Sort out by layer
      for (Entity e : this.world.entity_manager.component_store.get(SHAPE).keySet()) {

        if (e.active) {
          
          ShapeComponent sc = (ShapeComponent) e.getComponent(SHAPE);
          Transform t = (Transform) e.getComponent(TRANSFORM);

          transforms.put(sc, t);

          int z = sc.z;

          if (!this.z_tracker.containsKey(z)) {
            this.z_tracker.put(z, new ArrayList<ShapeComponent>());
          }

          this.z_tracker.get(z).add(sc);

          if (z < min_z) { 
            min_z = z;
          }
          
          if (z > max_z) { 
            max_z = z;
          }
        }

      }
      
      for (int i = max_z; i >= min_z; i--) {

        if (this.z_tracker.containsKey(i)) {

          for (ShapeComponent sc : this.z_tracker.get(i)) {

             Transform t = transforms.get(sc);
             Shape shape = sc.shape;
            
             if (t.getRotation() == 0) {

                shape.draw();

             } else {
              
                pushMatrix();
                translate(shape.centerPosition().x, shape.centerPosition().y);
                rotate(t.getRotation());
                shape.drawAroundOrigin();
                popMatrix();
              
             }


          }
        }
      }

    }
  }
}
