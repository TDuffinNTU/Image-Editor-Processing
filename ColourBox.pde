class Colourbox
{
   private int x, y;
   private PImage img;
   
   public Colourbox(int px, int py, int w, int h)
   {
     img = createImage(w, h, HSB);
     x = px; 
     y = py;
     this.UpdateColours(200);
   }
   
 
   public void Show()
   {
     // borderbox
     pushStyle();
     fill(0);
     rect(x-1, y-1, img.width+2, img.height+2);
     popStyle();
     
     // colourbox
     image(img,x,y);  
   }
   
   
   public void UpdateColours(float hue)
   {     
     
     // hue value of colour selected
     float h = hue;
  
     // account for any size of colourbox
     float xOff, yOff;
     xOff = 360/img.width;
     yOff = 360/img.height;
     
     // load pixels for setting
     img.loadPixels();
     colorMode(HSB);
     //img.pixels[img.width] = color(h, 360, 360);
          
     // make the blend!
     for (int col = 0; col < img.width; col++)
     {
       for (int row = 0; row < img.height; row++)
       {
         //img.pixels[row*img.width+col] = color(255, 360, 360);
         img.pixels[row*img.width + col] = color(h,(img.width-col)*xOff, (img.width-row)*yOff);       
         //print((10-col)*xOff);
         //print("\n");
       }
     }
     
     // push updates from buffer to box!
     img.updatePixels();
     colorMode(RGB);
     
   }
}
