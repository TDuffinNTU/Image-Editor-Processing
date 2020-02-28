SimpleUI myUI;
int bi = 10; // initial height bleed
int bh = 40; 
Colourbox colourbox;
ColourSwatch foreground, background;
PImage rainbow;

void setup()
{
  size(1200, 800);
  myUI = new SimpleUI();

  myUI.addImageButton("Draw Rectangle", 10, setButtonY(0), "buttons/rectangle.png");
  myUI.addImageButton("Create Text", 10, setButtonY(1), "buttons/text.png");
  myUI.addImageButton("Draw Bezier", 10, setButtonY(2), "buttons/bezier.png");
  myUI.addImageButton("Gradient", 10, setButtonY(3), "buttons/gradient.png");
  myUI.addImageButton("Select", 10, setButtonY(4), "buttons/select.png");
  myUI.addImageButton("Transparency", 10, setButtonY(5), "buttons/transparency.png");
  myUI.addImageButton("Line", 10, setButtonY(6), "buttons/line.png");
  myUI.addImageButton("Dropper", 10, setButtonY(7), "buttons/dropper.png");  
  myUI.addImageButton("Rotate", 10, setButtonY(8), "buttons/rotate.png");  
  myUI.addImageButton("Colourbox", width-139, 11, "buttons/colourbox.png");

  colourbox = new Colourbox(width-139, 11, 128, 128); 
  rainbow = loadImage("rainbow.png");
  myUI.addSlider("HueSlider", width-140, 150);
  myUI.setSliderHandleType("HueSlider", "NONE");
  
  foreground = (ColourSwatch)myUI.addColourSwatch("ForegroundSwatch", width-140, 190, myUI, color(0));
  background = (ColourSwatch)myUI.addColourSwatch("BackgroundSwatch", width-90, 190, myUI, color(255));
  foreground.selected = true;
  
}

int setButtonY(int btn_order)
{
  return bi + (btn_order * bh);
}

void draw()
{
  background(255);
  noStroke();
  fill(80);

  rect(0, 0, 50, height);
  rect(width-150, 0, 150, height); 

  myUI.update();
  colourbox.Show();
  image(rainbow, width-140, 150);
}

void handleUIEvent(UIEventData uied)
{
  uied.print(0);

  // Hue slider setting value
  if (uied.eventIsFromWidget("HueSlider"))
  {
    float newHue = uied.sliderValue * 255f;
    colourbox.UpdateColours(newHue);
    updateColourSwatch();    
  }

  // Colourbox colour selection
  if (uied.eventIsFromWidget("Colourbox")) //TODO : make colourbox its own widget. will save me messing with it so much.
  {
    colourbox.SelectColour(mouseX, mouseY);
    updateColourSwatch();
  }  
}

void updateColourSwatch()
{
  if(foreground.selected) {
      foreground.setColour(colourbox.getColour());
    } else {
      background.setColour(colourbox.getColour());
    }    
}
