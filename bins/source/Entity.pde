import fisica.*;

class Entity{
 public FBody body;
 
 public Entity(float x, float y, float size, float density){
  body = new FCircle(size);
  body.setPosition(x, y);
  body.setDensity(density);
  // body.addForce(50, 50);
 }
 
 public void addTo(FWorld theWorld){
  theWorld.add(body); 
 }
 
}
