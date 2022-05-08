static class SaveBody implements java.io.Serializable{
 public float xPos, yPos;
 public float xVel, yVel;
 public float xF, yF;
 public float size, density;
 public SaveBody(float a, float b, float c, float d, float e, float f, float s, float dens){
   xPos = a;
   yPos = b;
   xVel = c;
   yVel = d;
   xF = e;
   yF = f;
   size = s;
   density = dens;
 }
}
