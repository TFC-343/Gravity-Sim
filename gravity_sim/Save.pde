static class Save implements java.io.Serializable{
 String name;
 public ArrayList<SaveBody> bodies;
 public Save(String n){
   name = n;
   bodies = new ArrayList<SaveBody>();
 }
 
 public String getName(){
  return name; 
 }
}
