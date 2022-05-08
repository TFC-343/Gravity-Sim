import fisica.*;

FWorld world;
Entity ent1;
Entity ent2;
Entity ent3;
float G = 50;

float launchX, launchY;
boolean launching = false;
boolean paused = false;

Settings settings;
SavesTab saves;

Save toSave(FWorld world){
 Save save = new Save("New Save");
 ArrayList<FCircle> bodies = world.getBodies();
 FCircle b;
 for (int i = 0; i < bodies.size(); i++){
   b = bodies.get(i);
   save.bodies.add(new SaveBody(b.getX(), b.getY(), b.getVelocityX(), b.getVelocityY(), b.getForceX(), b.getForceY(), b.getSize(), b.getDensity())); 
 }
 return save;
}

FWorld toWorld(Save save){
  FWorld nWorld = new FWorld();
  nWorld.setGravity(0, 0);
  nWorld.setGrabbable(false);
  ArrayList<SaveBody> bodies = save.bodies;
  SaveBody s;
  for (int i = 0; i < bodies.size(); i++){
   s = bodies.get(i);
   FCircle n = new FCircle(s.size);
   n.setDensity(s.density);
   n.setPosition(s.xPos, s.yPos);
   n.setVelocity(s.xVel, s.yVel);
   n.addForce(s.xF, s.yF);
   nWorld.add(n);
  }
  return nWorld;
  
}

float forceTo(FBody a, FBody b){
  return G * a.getMass() * b.getMass() / sqrt(pow(a.getX() - b.getX(), 2) + pow(a.getY() - b.getY(), 2));
}

float angleTo(FBody a, FBody b){
  return atan2(b.getY() - a.getY(), b.getX() - a.getX());
}

void setup(){
 size(800, 800);
  
 Fisica.init(this);
 world = new FWorld();
 world.setGravity(0, 0);
 world.setGrabbable(false);
 
 
 settings = new Settings();
 saves = new SavesTab();
 
}

void draw(){
 background(100);
 
 if (!paused){ 
   world.step();
   ArrayList<FBody> bodies = world.getBodies();
   for (int i = 0; i < bodies.size(); i++){
     for (int j = 0; j < bodies.size(); j++){
      if (i == j){
       continue; 
      }
      float force, ang;
      force = forceTo(bodies.get(i), bodies.get(j));
      ang = angleTo(bodies.get(i), bodies.get(j));
      bodies.get(i).addForce(force * cos(ang), force * sin(ang));
     }
   }
 }
 
 G = settings.gravity.getVal();
 
 
 world.draw();
 settings.draw();
 saves.draw();
 
 if (launching){
   line(launchX, launchY, mouseX, mouseY);
   fill(255, 255, 255, 200);
   circle(launchX, launchY, settings.size.getVal());
   fill(255);
 }
 
 if (!paused){
  triangle(25, 25, 25, 75, 75, 50); 
 }
 else{
  rect(25, 25, 20, 50); 
  rect(50, 25, 20, 50); 
 }
 
}

void mousePressed(){
 if (mouseY > settings.pos || mouseX > saves.pos || settings.open || saves.open){
   return;
 }
 else if(25 < mouseX && mouseX < 75 && 25 < mouseY && mouseY < 75){
   paused = !paused;
   return;
 }
 launching = true;
 launchX = mouseX;
 launchY = mouseY;
}

void mouseReleased(){
 if (!launching) { return; } 
 launching = false;
 Entity newEnt = new Entity(launchX, launchY, settings.size.getVal(), settings.density.getVal());
 float force = 5 * sqrt(pow(launchX - mouseX, 2) + pow(launchY - mouseY, 2));
 float ang = atan2(mouseY - launchY, mouseX - launchX);
 // newEnt.body.addForce(force * cos(ang), force * sin(ang));
 newEnt.body.setVelocity(force * cos(ang), force * sin(ang));
 newEnt.addTo(world);
}

void keyPressed(){
  if (keyCode == ESC){
   launching = false;
   key = 0;
  }
  else if(key == 'p'){
    paused = !paused;
  }
}

void mouseClicked(){
  if (saves.pos + 35 < mouseX && mouseX < saves.pos + 115 && 705 < mouseY && mouseY < 785){
    // Saves the current world to a file
    
    java.awt.FileDialog file = new java.awt.FileDialog((java.awt.Frame) null, "Save File", java.awt.FileDialog.SAVE);
    file.setVisible(true);
    String path = file.getDirectory();
    String name = file.getFile();
    println(path);
    
    if (name != null){
      try{
        File newFile = new File(path + name);
        newFile.createNewFile();
        java.io.FileOutputStream fileOut = new java.io.FileOutputStream(newFile, false);
        java.io.ObjectOutputStream out = new java.io.ObjectOutputStream(fileOut);
        Save s = toSave(world);
        out.writeObject(s);
        out.close();
        fileOut.close();
      }
      catch (IOException i){
       i.printStackTrace(); 
      } 
    }
  }
  else if (saves.pos + 20 + 15 < mouseX && mouseX < saves.pos + 20 + 15 + 80 && 7 * 90 - 15 < mouseY && mouseY < 7 * 90 - 15 + 80){
    java.awt.FileDialog file = new java.awt.FileDialog((java.awt.Frame) null, "Load File", java.awt.FileDialog.LOAD);
    file.setVisible(true);
    String path = file.getDirectory();
    String name = file.getFile();
    println(path);
    
    if (name != null){
      Save s;
      try{
        File newFile = new File(path + name);
        java.io.FileInputStream fileIn = new java.io.FileInputStream(newFile);
        java.io.ObjectInputStream in = new java.io.ObjectInputStream(fileIn);
        s = (Save) in.readObject();
        FWorld n = toWorld(s);
        saves.addWorld(n);
        world = n;
        in.close();
        fileIn.close();
      }
      catch (IOException i){
       i.printStackTrace(); 
      } 
      catch (ClassNotFoundException c){
        c.printStackTrace();
      }
    }
  }


      
 saves.mouseClicked(); 
}
