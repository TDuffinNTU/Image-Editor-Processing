class Colourbox // TODO: Make this into SimpleUI widget (hello dev branch!)
{
   private int x, y, lineX, lineY;
   private PImage img;
   private color selected;
   
   public Colourbox(int px, int py, int w, int h)
   {
     img = createImage(w, h, HSB);
     lineX = x = px;
     lineY = y = py;
     this.UpdateColours(200);
     
     print(w*h, "\n");
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
     
     // selection crosshair
     stroke(255);
     line(lineX, y, lineX, y+img.height);
     line(x, lineY, x+img.width, lineY);
   }
   
   // sets crosshair to position of selected col, sets selected col from pixel data
   public void SelectColour(int mx, int my)
   {
     lineX = mx;
     lineY = my;
     
     int col = lineX - x;
     int row = lineY - y;    
     
     // a bit janky, but it gets the job done..
     selected = img.pixels[min(row*img.width + col, img.width*img.width-1)];
   }
   
   
   // set the hue spectrum gradient to a new colour
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
     
     // reselect colour
     SelectColour(lineX,lineY);
     
     // push updates from buffer to box
     img.updatePixels();
     colorMode(RGB);
     
   }
}
