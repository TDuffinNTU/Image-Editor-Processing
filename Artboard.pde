public class Artboard 
{
  ArrayList<ArtboardElement> elements;
  PGraphics artboard;
  int canvasX, canvasY;
  
  boolean isDraggingElement = false;
  PVector dragOffset;
  
  
  public Artboard(int x, int y, int w, int h) 
  {
    artboard = createGraphics(w, h); // create canvas for printing on    
    canvasX = x;
    canvasY = y;
    elements = new ArrayList<ArtboardElement>();    // list of elements, defines the order they show on screen in LIFO order
  }
  
  public boolean artboardHasElements() { return !elements.isEmpty(); }
  
  // get and set dragging feature
  public boolean isDraggingElement() {  return isDraggingElement;  }
  public void  setIsDraggingElement(boolean dragging) {  isDraggingElement = dragging; } 
  public PVector getDragOffset() {  return dragOffset;  }
  public void setDragOffset(PVector offset) {  dragOffset = offset;  } 
  
  
  public ArtboardElement getSelectedElement() 
  {
    for(ArtboardElement element : elements) 
    {
      if(element.getIsSelected()) return element;
    }
    
    return null;
  }
  
  public void selectElement(ArtboardElement e) 
  {   
    e.setIsSelected(!e.getIsSelected()); // toggle selection of element
    for (ArtboardElement element : elements) { if(!element.equals(e))  element.setIsSelected(false);  } //deselect other elements
  }
  
  public ArtboardElement elementAtPosition(int mx, int my) 
  {
    if(!artboardHasElements()) return null;
    // reverse thru arraylist to get topmost object selected
    for(int i = elements.size() - 1; i != -1; i--) 
    {
      if(elements.get(i).getBounds().isPointInside(new PVector(mx, my))) {
        selectElement(elements.get(i));        
        return elements.get(i);        
      }
    }
    
    return null;
  }
  
  public ArtboardElement selectElement(int mx, int my) 
  {   
    if(!artboardHasElements()) return null;
    // reverse thru arraylist to get topmost object selected
    for(int i = elements.size() - 1; i != -1; i--) 
    {
      if(elements.get(i).getBounds().isPointInside(new PVector(mx, my))) {
        elements.get(i).setIsSelected(!elements.get(i).getIsSelected());
        return elements.get(i);        
      }
    }
    
    return null;
  }
  
  public void saveGraphics(String location, String type) // saves the artboard contents as an image file of chosen type.
  {
    if(!type.equals(".png") && !type.equals(".tiff") && !type.equals(".tga"))  type = ""; // santizing input
    
    artboard.beginDraw();    
    
    // each elements calls element.artboardDraw() to push image data to buffer
    for(ArtboardElement element : elements) {
      element.artboardDraw(artboard);
    }
    artboard.endDraw();
    
    artboard.save(location + type); // save graphics buffer to file 
  }
  
  public void drawMe() 
  {
    for (ArtboardElement element : elements) 
    {
      element.drawMe();
      element.drawSelection();
    }
  }
  
  public void addElement(ArtboardElement e) 
  {
    e.CanvasX = X; e.CanvasY = Y;
    elements.add(e);
  }
  
  public void removeElement(ArtboardElement e) 
  {
    for (ArtboardElement element : elements) {
      if (element.equals(e)) {
        elements.remove(e);
        return;
      }
    }
  }
}

public class ArtboardElement {
  float X, Y;
  int CanvasX, CanvasY;
  UIRect bounds;
  boolean isSelected;
  String Name;
  String Type;
  color SELECT_COLOUR = color(50, 250, 50);
  int TEXT_SIZE = 16;
  int TEXT_PAD = 5;
  int BOUND_WEIGHT = 5;
  
  public ArtboardElement(String name, String type, float x, float y)
  {
    Name = name; Type = type; X = x; Y = y;
    isSelected = false;
  }
  
  public void setPosition(float x, float y) 
  {    
    X = x; Y= y; updateBounds();
  }
  
  public void updateBounds() 
  {
    // VIRTUAL
  }
  
  public UIRect getBounds() {return bounds;}
  public String getType() {return Type;}
  
  public boolean getIsSelected() {return isSelected;}
  public void setIsSelected(boolean selected) {isSelected = selected;}
  
  public void drawMe() 
  {
    // VIRTUAL
  }
  
  public void artboardDraw(PGraphics artboard) 
  {
    // VIRTUAL
  }
  
  public void drawSelection()
  {        
    if (isSelected) // show selection around/over element
    {
      pushStyle();
        stroke(SELECT_COLOUR);
        strokeWeight(BOUND_WEIGHT);
        fill(SELECT_COLOUR);
        textSize(TEXT_SIZE); // text label displaying name and type
        text(Name + ":" + Type, bounds.left+TEXT_PAD, bounds.top - TEXT_PAD);
        noFill(); // outline element
        rect(bounds.left, bounds.top, bounds.getWidth(), bounds.getHeight());
        
        // lines across midpoint
        
        line(bounds.left, bounds.top, bounds.right, bounds.bottom);
        line(bounds.right, bounds.top, bounds.left, bounds.bottom);
      popStyle();      
    }
  }
}

public class ImageElement extends ArtboardElement {
  // wrapping PImage in artboardElement to make it polymorphic with other drawables
  PImage image;
  public ImageElement(String name, float x, float y, PImage img) 
  { 
    super(name, "IMAGE", x, y);
    image = img;
    updateBounds();
  }
  
  public void updateBounds() 
  {
    bounds = new UIRect(X, Y, X+image.width, Y+image.height);
  }
  
  public void drawMe() 
  {
    image(image, X+CanvasX, Y+CanvasY); // use offsets provided to show on screen correctly
  }
  
  public void artboardDraw(PGraphics artboard) 
  {
    artboard.image(image,X,Y); // however don't use offsets here as we're not drawing to screen!
  } 
  
  public PImage getImage() {  return image;  }   
  public void setImage(PImage img) { image = img.copy(); }
  
}
