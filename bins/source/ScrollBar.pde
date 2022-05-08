class ScrollBar{
  float startVal, endVal, currentVal;
  float defaultVal;
  public float x, y;
  float size;
  boolean grabbed;
  String name;
  public ScrollBar(String n,float a, float b, float s, float v1, float v2, float d){
   x = a;
   y = b;
   size = s;
   startVal = v1;
   endVal = v2;   
   defaultVal = d;
   currentVal = d;
   grabbed = false;
   name = n;
  }
  
  public void draw(){
    
   if (mousePressed){
     // x + size / 2 - 15, y - 10, 20, 20)
     if (x + size / 2 + 15 < mouseX && mouseX < x + size / 2 + 35 && y - 10 < mouseY && mouseY < y + 20){
      currentVal = defaultVal;
     }
     if (sqrt(pow(mouseX - getPos(), 2) + pow(mouseY - y, 2)) < 30){
      grabbed = true;
     }
   }
   else{
    grabbed = false; 
   }
   
   if (grabbed){
     currentVal = startVal + (endVal - startVal) * (mouseX - (x - size / 2))/(size);
     if (currentVal < startVal){
       currentVal = startVal;
     }
     else if (currentVal > endVal){
      currentVal = endVal; 
     }
   }
    
   int oldColour = g.fillColor;
   fill(60);
   rect(x - size / 2, y - 4, size, 8, 5, 5, 5, 5); 
   fill(200);
   circle(getPos(), y, 30);
   fill(0);
   textSize(20);
   text(str(startVal), x - size / 2, y - 10);
   text(str(endVal), x + size / 2 - 30, y - 10);
   text(str(float(round(currentVal * 100)) / 100), x - size / 3, y - 10);
   textSize(30);
   text(name, x - 30, y - 15);
   fill(100);
   rect(x + size / 2 - 10 + 25, y - 10, 20, 20);
   fill(30);
   textSize(25);
   text("R", x + size / 2 - 7 + 25, y + 10);
   
   fill(oldColour);
  }
  
  public float getPos(){
   return (x - size / 2) + size * ((currentVal - startVal)/(endVal - startVal));
  }
  
  public float getVal(){
   return currentVal; 
  }
  
  
}
