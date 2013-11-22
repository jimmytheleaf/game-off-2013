int width = 960;
int height = 640;

World world;

void setup() 
{

  size(960, 640, P2D);
  //runTests();
  colorMode(RGB, 255, 255, 255, 255);
  rectMode(CORNER);

  world = new World(960, 640);

  setUpSystems(world);

  background(63, 63, 63);
  noStroke();

  LevelGateway gateway = new LevelGateway(world);
  world.scene_manager.addScene(gateway);
  world.scene_manager.setCurrentScene(gateway);

}


void setUpSystems(World world) {

  TweenSystem tween_system = new TweenSystem(world);
  MovementSystem movement_system = new MovementSystem(world);
  BehaviorSystem behavior_system = new BehaviorSystem(world);
  InputSystem input_system = new InputSystem(world);
  RenderingSystem rendering_system = new RenderingSystem(world);
  CollisionSystem collision_system = new CollisionSystem(world);

  SpringSystem spring_system = new SpringSystem(world);
  PhysicsSystem physics_system = new PhysicsSystem(world);

  world.setSystem(tween_system);
  world.setSystem(movement_system);
  world.setSystem(behavior_system);
  world.setSystem(input_system);
  world.setSystem(rendering_system);
  world.setSystem(collision_system);
  world.setSystem(spring_system);
  world.setSystem(physics_system);

  input_system.registerInput('W', ACTION_UP);
  input_system.registerInput('S', ACTION_DOWN);
  input_system.registerInput('A', ACTION_LEFT);
  input_system.registerInput('D', ACTION_RIGHT);

}

void update(float dt) {

  Scene current_scene = world.scene_manager.getCurrentScene();
  current_scene.update(dt);

}


void draw() 
{

  Scene current_scene = world.scene_manager.getCurrentScene();
  current_scene.draw();

}

void keyReleased() {

  key = normalizeInput(key);

  InputSystem input_system = (InputSystem) world.getSystem(INPUT_SYSTEM);
  input_system.keyReleased(key);
}

void keyPressed() {
  
  key = normalizeInput(key);

  InputSystem input_system = (InputSystem) world.getSystem(INPUT_SYSTEM);
  input_system.keyPressed(key);

}

void mouseClicked() {
 
  Scene current_scene = world.scene_manager.getCurrentScene();
  current_scene.mouseClicked();

}
