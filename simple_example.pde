SimpleUI myUI;
int bi = 10; // initial height bleed
int bh = 40; 
PImage colourbox;
void setup()
{
  size(1200,800);
  myUI = new SimpleUI();
  
  myUI.addImageButton("Draw Rectangle",10,     setButtonY(0),"buttons/rectangle.png");
  myUI.addImageButton("Create Text",10,        setButtonY(1),"buttons/text.png");
  myUI.addImageButton("Draw Bezier",10,        setButtonY(2),"buttons/bezier.png");
  myUI.addImageButton("Gradient",10,           setButtonY(3),"buttons/gradient.png");
  myUI.addImageButton("Select",10,             setButtonY(4),"buttons/select.png");
  myUI.addImageButton("Transparency",10,       setButtonY(5),"buttons/transparency.png");
  myUI.addImageButton("Line",10,               setButtonY(6),"buttons/line.png");
  myUI.addImageButton("Dropper",10,            setButtonY(7),"buttons/dropper.png");  
  myUI.addImageButton("Rotate",10,             setButtonY(8),"buttons/rotate.png");  
  
  colourbox = loadImage("colourbox.png"); 
  
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
  
  
  rect(0,0,50,height);
  rect(width-150,0,150,height);
  image(colourbox, width - 140, 10);
  
  myUI.update();
}

void handleUIEvent(UIEventData uied)
{
  uied.print(3);
}
