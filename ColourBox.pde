class Colourbox
{
   private int x, y;
   private PImage img;
   
   public Colourbox(int px, int py, int w, int h)
   {
     img = createImage(w, h, RGB);
     x = px; 
     y = py;
   }
   
 
   public void Show()
   {
     image(img,x,y);  
   }
   
   
   public void UpdateColours()
   {
   
   }
}
