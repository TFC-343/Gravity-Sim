class Settings{
 boolean open;
 float pos;
 float openSize, closedSize;
 public ScrollBar gravity;
 public ScrollBar size;
 public ScrollBar density;
 public Settings(){
  open = false;
  openSize = 620;
  closedSize = 780;
  
  pos = closedSize;
  
  gravity = new ScrollBar("G", 400, 500, 700, 0, 100, 13.5);
  size = new ScrollBar("size", 400, 500, 700, 25, 250, 50);
  density = new ScrollBar("density", 400, 500, 700, 5, 1000, 50);
 }
 
 public void draw(){
   if (mouseY > closedSize){
    open = true; 
   }
   else if(mouseY < openSize){
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
   
   gravity.y = pos + 50;
   size.y = pos + 100;
   density.y = pos + 150;
      
   
   rect(0, pos, 800, 400, 25, 25, 0, 0);
   gravity.draw();
   size.draw();
   density.draw();
 }
  
}
