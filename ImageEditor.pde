public class ImageEditor extends SimpleUIWrapper 
{
  int DEFAULT_W = 800; int DEFAULT_H = 800;
  int DocW, DocH;
  
  int BUTTON_BLEED = 50;
  int BUTTON_HEIGHT = 40;
  int CANVAS_X = 50;
  int CANVAS_Y = 25;
  
  //Artboard ab;
  PVector dragOffset;
  
  
  String[] FileMenuItems = {"New", "Open...", "Save", "Save As..."};
  String[] EditMenuItems = {"Undo", "Redo", "Delete"};
  String[] EffectsMenuItems = {"Threshold", "Opacity"};
  
  Colourbox colourbox;
  PImage rainbow;
  ColourSwatch foreground, background;
  
  int IMAGE_X = 0;
  int IMAGE_Y = 0;
  
  public ImageEditor()
  {
    super("ImageEditor", true);        
    DocW = DEFAULT_W;
    DocH = DEFAULT_H;
    //artboardImages = new ArrayList<PImage>();
    //artboard = createGraphics(DocW, DocH);
    
    
    setupUI();
  }   
  
  public void SetDocumentSize(int w, int h) 
  {
    DocW = w; DocH = h; setupUI();
    //print(w, h);
  }
  
  public void setupUI()
  {
    ui.clearAll();
    //artboardImages = new ArrayList<PImage>();
    // Canvas is the document size, menu later.
    surface.setSize( DocW + 200, DocH + 25);      
    
    // Left side buttons
    ui.addImageButton("Draw Rectangle", 10, setButtonY(0), "buttons/rectangle.png", "LeftMenu", ui);
    ui.addImageButton("Create Text", 10, setButtonY(1), "buttons/text.png", "LeftMenu", ui);
    ui.addImageButton("Draw Bezier", 10, setButtonY(2), "buttons/bezier.png", "LeftMenu", ui);
    ui.addImageButton("Gradient", 10, setButtonY(3), "buttons/gradient.png", "LeftMenu", ui);
    ui.addImageButton("Select", 10, setButtonY(4), "buttons/select.png", "LeftMenu", ui);
    ui.addImageButton("Transparency", 10, setButtonY(5), "buttons/transparency.png", "LeftMenu", ui);
    ui.addImageButton("Line", 10, setButtonY(6), "buttons/line.png", "LeftMenu", ui);
    ui.addImageButton("Dropper", 10, setButtonY(7), "buttons/dropper.png", "LeftMenu", ui);  
    ui.addImageButton("Rotate", 10, setButtonY(8), "buttons/rotate.png", "LeftMenu", ui);  
    ui.addLabel("Inspector", width-140, 280, ""); 
    
    
    // top dropdown menu
    ui.addMenu("File", 50, 0, FileMenuItems); 
    ui.addMenu("Edit", 130, 0, EditMenuItems);
    ui.addMenu("Effects", 210, 0, EffectsMenuItems);   
    
    // colourbox and swatches
    ui.addImageButton("Colourbox", width-139, 11, "buttons/colourbox.png", "ColourBox", ui);
    colourbox = new Colourbox(width-139, 11, 128, 128); 
    rainbow = loadImage("rainbow.png");
    ui.addSlider("HueSlider", width-140, 150);
    ui.setSliderHandleType("HueSlider", "NONE");
    
    foreground = ui.addColourSwatch("ForegroundSwatch", width-140, 190, ui, color(0));
    background = ui.addColourSwatch("BackgroundSwatch", width-90, 190, ui, color(255));
    foreground.selected = true; 
    
    // Canvas stuff
    ui.addCanvas(CANVAS_X, CANVAS_Y, DocW, DocH); 
    ab = new Artboard(CANVAS_X, CANVAS_Y, DocW, DocH);
    //artboard = createGraphics(DocW, DocH);
    
  }
  
  public void handleEvent(UIEventData uied) 
  {
    // Hue slider setting value
    if (uied.eventIsFromWidget("HueSlider"))
    {
      float newHue = uied.sliderValue * 255f;
      colourbox.UpdateColours(newHue);
      updateColourSwatch();    
    }
  
    // Colourbox colour selection
    else if (uied.eventIsFromWidget("Colourbox")) 
    {
      colourbox.SelectColour(mouseX, mouseY);
      updateColourSwatch();
    }  
    
    else if (uied.eventIsFromWidget("File"))
    {
      String option = uied.menuItem;
      
      if      (option == FileMenuItems[0]) getUI("NewDocument").ui.setEnabled(!getUI("NewDocument").ui.getEnabled());      
      else if (option == FileMenuItems[1]) ui.openFileLoadDialog("Open File");   
      else if (option == FileMenuItems[2]){ui.openFileSaveDialog("Save Image");}
    }
    
    else if (uied.eventIsFromWidget("Edit")) 
    {
      String option = uied.menuItem;
      if (option == EditMenuItems[0]);
      else if (option == EditMenuItems[1]);
      else if (option == EditMenuItems[2]) if (ab.getSelectedElement() != null) ab.removeElement(ab.getSelectedElement()); ;
      //else if (option == EditMenuItems[0]);
    }
    
    else if (uied.eventIsFromWidget("Effects"))
    {
      //disable them all first
      getUI("Threshold").ui.setEnabled(false);
      getUI("Opacity").ui.setEnabled(false);
      String option = uied.menuItem;
      // threshold filter
      if (option == EffectsMenuItems[0] && ab.getSelectedElement() != null) {
        ThresholdUI tui = (ThresholdUI)getUI("Threshold");
        tui.ui.setEnabled(true);    
        tui.setElement(ab.getSelectedElement());
      }
      // opacity filter
      if (option == EffectsMenuItems[1] && ab.getSelectedElement() != null) {
        OpacityUI oui = (OpacityUI)getUI("Opacity");
        oui.ui.setEnabled(true);
        oui.setElement(ab.getSelectedElement());
      }
      
    }
    
    else if (uied.eventIsFromWidget("fileSaveDialog"))
    {
      String[] saveArgs = split(uied.fileSelection, ".");
      ab.saveGraphics(saveArgs[0], saveArgs[1]);
    }
    
    else if (uied.eventIsFromWidget("fileLoadDialog"))
    {
      ImageElement newImg = new ImageElement(uied.fileSelection, 0, 0, loadImage(uied.fileSelection));
      ab.addElement(newImg);
      print(uied.fileSelection);
    }
    
    else if (uied.eventIsFromWidget("canvas"))
    {  
     
      
      
      if (ui.getWidget("Select").selected) 
      {      
        // setting drag offset if user wants to move an item...
        if (uied.mouseEventType == "mousePressed") 
        {   
          ArtboardElement e = ab.getSelectedElement();
          if (e != null && !ab.isDraggingElement()) {
            ab.setDragOffset(new PVector(mouseX - e.X, mouseY - e.Y));          
          }          
        }
        
        if (uied.mouseEventType == "mouseReleased") 
        {
          ab.elementAtPosition(mouseX, mouseY);
          if (ab.isDraggingElement())  {  ab.setIsDraggingElement(false);  }
        }
        
        if (uied.mouseEventType == "mouseDragged" && ab.getSelectedElement() != null) 
        {
          ArtboardElement e = ab.getSelectedElement();
          e.X = (int)(mouseX - ab.dragOffset.x);
          e.Y = (int)(mouseY - ab.dragOffset.y);
          e.updateBounds();
          ab.setIsDraggingElement(true);
        }    
      }          
    }
  }
  
  
  public void drawOther()
  {
    
    background(255);  
    ab.drawMe();
    
    noStroke();
    fill(80);

    // left menu container
    rect(0, 0, CANVAS_X, height);
  
    // right menu container
    rect(width-150, 0, 150, height); 
    
    pushStyle(); // container for "inspector"
      fill(100);
      noStroke();
      rect(width-145, 320, 140, 450);
    popStyle();
    
    // top menu container
    rect(CANVAS_X, 0, DocW, CANVAS_Y);
    
    
    
  }
  
  public void drawUI() 
  {
    ui.update();
    colourbox.drawMe();
    image(rainbow, width-140, 150);
  }
  
  private int setButtonY(int btn_order)
  {
    return BUTTON_BLEED + (btn_order * BUTTON_HEIGHT);
  }
  
  private void updateColourSwatch()
  {
    color col = colourbox.getColour();
    if(foreground.selected)
    {
      foreground.setColour(col);
    } 
    else if (background.selected) 
    {
      background.setColour(col);
    }
  }
}
