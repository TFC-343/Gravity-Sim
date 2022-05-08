class SavesTab{
  boolean open;
  float pos;
  float openSize, closedSize;
  ArrayList<FWorld> worlds;
  ArrayList<PGraphics> icons;
  int currentWorld;
  public SavesTab(){
    open = false;
    openSize = 670;
    closedSize = 780;
    pos = closedSize;
    worlds = new ArrayList<FWorld>();
    worlds.add(null);
    worlds.add(new FWorld());
    
    icons = new ArrayList<PGraphics>();
    icons.add(null);
    icons.add(createGraphics(800, 800));

    
    currentWorld = 1;
  }
  
  public void draw(){
    if (350 < mouseY && mouseY < 450 && mouseX > closedSize){
      open = true; 
    }
    else if(mouseX < openSize){
      open = false; 
     }
   
    if (open){
      if (pos > openSize){
       pos -= 5; 
      }
     }
     else{
       if (pos < closedSize){
         pos += 5;
        }
      }
      
      rect(pos, 350, 20, 100, 25, 0, 0, 25);
      rect(pos + 20, 0, 400, 800);
      stroke(255);
      line(pos + 20, 350, pos + 20, 450);
      stroke(0);
      
      fill(40);
      
      for (int i = 0; i < worlds.size(); i++){
        float xPos = pos + 20 + 15;
        float yPos = 15 + i * 90;
        int colour = 40;
        int sColour = 255;
        if (i == currentWorld){
          colour = 150;
          sColour = 0;
        }
        else if (xPos < mouseX && mouseX < xPos + 80 && yPos < mouseY && mouseY < yPos + 80){
         colour = 100;
        }
        // rect(xPos, yPos, 80, 80);
        if (i > 0){
          PGraphics icon = createGraphics(800, 800);
          icon.beginDraw();
          icon.background(colour);
          worlds.get(i).draw(icon);
          icon.endDraw();
          PImage img = icon.get();
          img.resize(80, 80);
          image(img, xPos, yPos);
          
          stroke(sColour);
          line(xPos + 65, yPos + 5, xPos + 75, yPos + 15);
          line(xPos + 65, yPos + 15, xPos + 75, yPos + 5);
          stroke(0);
        } else {
          fill(colour);
          rect(pos + 35, 15, 80, 80);
        }
      }
      fill(255);
      rect(pos + 20 + 15 + 30, 15 + 10, 80 - 60, 80 - 20);
      rect(pos + 20 + 15 + 10, 15 + 30, 80 - 20, 80 - 60);
      stroke(255);
      line(pos + 20 + 15 + 30, 15 + 30, pos + 20 + 15 + 30 + 20, 15 + 30);
      line(pos + 20 + 15 + 30, 15 + 30 + 20, pos + 20 + 15 + 30 + 20, 15 + 30 + 20);
      stroke(0);
      
      float xPos = pos + 20 + 15;
      float yPos = 8 * 90 - 15;
      fill(255);
      if (xPos < mouseX && mouseX < xPos + 80 && yPos < mouseY && mouseY < yPos + 80){
        fill(100);
      }
      rect(xPos, yPos, 80, 80);
      // line(pos + 20, yPos - 15, 800, yPos - 15);
      fill(0);
      text("save", xPos + 10, yPos + 50);
      fill(255);
      
      xPos = pos + 20 + 15;
      yPos = 7 * 90 - 15;
      fill(255);
      if (xPos < mouseX && mouseX < xPos + 80 && yPos < mouseY && mouseY < yPos + 80){
        fill(100);
      }
      rect(xPos, yPos, 80, 80);
      line(pos + 20, yPos - 15, 800, yPos - 15);
      fill(0);
      text("load", xPos + 10, yPos + 50);
      fill(255);
    }
    
  public void mouseClicked(){
      if (mouseButton != LEFT){
        return;
      }
      
      for (int i = 0; i < worlds.size(); i++){
        float xPos = pos + 20 + 15;
        float yPos = 15 + i * 90;
        if (xPos < mouseX && mouseX < xPos + 80 && yPos < mouseY && mouseY < yPos + 80){
          worlds.set(currentWorld, world);
         if (i == 0){
           if (worlds.size() <= 5){
             currentWorld = 1;
             FWorld newWorld = new FWorld();
             newWorld.setGravity(0, 0);
             newWorld.setGrabbable(false);
             worlds.add(1, newWorld);
             world = worlds.get(currentWorld);
             icons.add(createGraphics(90, 90));
           }
         }
         else if (xPos + 65 < mouseX && mouseX < xPos + 75 && yPos + 5 < mouseY && mouseY < yPos + 15){
           if (i > 0 && worlds.size() > 2){
             worlds.remove(i);
             icons.remove(i);
             currentWorld = currentWorld - 1;
             if (currentWorld < 1){
               currentWorld = 1;
               world = worlds.get(currentWorld);
             }
             else{
               world = worlds.get(currentWorld);
             }
           }
         }
         else{
           currentWorld = i;
           world = worlds.get(i);
         }
         break;
        }
      }
    }
    
  public void addWorld(FWorld newWorld){
    currentWorld = worlds.size();
    worlds.add(newWorld);
    icons.add(createGraphics(90, 90));
  }
}
