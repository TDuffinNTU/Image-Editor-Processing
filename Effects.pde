
// threshold image effect
public class ThresholdUI extends SimpleUIWrapper
{
  PImage baseImage;
  PImage newImage;
  ImageElement imageElement;
  
  TextInputBox valueBox;
  Slider valueSlider;
  
  public ThresholdUI()
  {    
    super("Threshold", false);
    setupUI();
     
  }
  
  private void setElement(ArtboardElement ae) {
    if (ae.getType() == "IMAGE") {imageElement = (ImageElement)ae;
    baseImage = imageElement.getImage().copy();
    newImage = baseImage.copy();  
  }
  }
  
  // update pixels of our "preview";
  private void updateEffect(float val) 
  {    
    
    colorMode(RGB);
    //newImage = baseImage.copy();
    //baseImage.loadPixels();
    //newImage.loadPixels();
    
    for (int y=0; y< baseImage.height; y++)
    {
      for(int x=0; x< baseImage.width; x++)
      {
        float tone = getTone(x,y);
        //print(tone-val);
        if (tone < val)
        {
          newImage.set(x,y,color(0));        
        }
        else
        {
          newImage.set(x,y,color(255));
        }
      } 
    }    
    
    //imageElement.setImage(newImage);
    
  }
  
  // get tone between 0 and 1
  private float getTone(int x, int y)
  {
    colorMode(RGB);
    color thisPix = baseImage.get(x,y);
    float tone = (red(thisPix) + green(thisPix) + blue(thisPix)) / 3.0f;
    //tone = tone/255;
    //print("\ntone: ", tone);
    return tone;
  }
  
  
  protected void setupUI() 
  {      
    valueSlider = ui.addSlider("Value", width-140, 340);
    valueBox = ui.addTextInputBox("Val", width-140, 380);   
    valueBox.setMaxChars(3);
    ui.addToggleButton("Confirm", width-140, 420);
    ui.addToggleButton("Reset", width-140, 460);        
  }
  
  public void handleEvent(UIEventData uied) 
  {   
   if (uied.eventIsFromWidget("Value"))
    {
      float newValue = uied.sliderValue*255f;
      valueBox.setText(str(int(newValue))); 
      updateEffect(newValue);
      print("\n", newValue);
    }
    
    if(uied.eventIsFromWidget("Val"))
    {     
      float newValue = parseInt(trim(valueBox.contents));     
      valueSlider.setSliderValue(newValue);
      updateEffect(newValue);
      print("\n", newValue);
    }
    
    if(uied.eventIsFromWidget("Confirm")){ imageElement.setImage(newImage); ui.setEnabled(false);}
    if(uied.eventIsFromWidget("Reset")) { imageElement.setImage(baseImage); }
  }
  
  protected void drawOther() 
  {
    image(newImage, imageElement.X+imageElement.CanvasX, imageElement.Y+imageElement.CanvasY);
  }
  
  protected void drawUI() 
  {
    ui.update();
  } 
  
}


// Set opacity of the image
public class OpacityUI extends SimpleUIWrapper
{
  PImage baseImage;
  PImage newImage;
  ImageElement imageElement;
  
  TextInputBox valueBox;
  Slider valueSlider;
  
  public OpacityUI()
  {    
    super("Opacity", false);
    setupUI();
     
  }
  
  private void setElement(ArtboardElement ae) {
    if (ae.getType() == "IMAGE") {imageElement = (ImageElement)ae;
    baseImage = imageElement.getImage().copy();
    newImage = baseImage.copy();  
  }
  }
  
  // update pixels of our "preview";
  private void updateEffect(float val) 
  {    
    
    colorMode(RGB);
    //newImage = baseImage.copy();
    //baseImage.loadPixels();
    //newImage.loadPixels();
    
    for (int y=0; y< baseImage.height; y++)
    {
      for(int x=0; x< baseImage.width; x++)
      {
        color thisPix = baseImage.get(x,y);
        thisPix = color(red(thisPix), green(thisPix), blue(thisPix), val);
        newImage.set(x, y, thisPix);
      } 
    }    
    
    //imageElement.setImage(newImage);    
  }
  
  
  
  
  protected void setupUI() 
  {      
    valueSlider = ui.addSlider("Value", width-140, 340);
    valueBox = ui.addTextInputBox("Val", width-140, 380);   
    valueBox.setMaxChars(3);
    ui.addToggleButton("Confirm", width-140, 420);
    ui.addToggleButton("Reset", width-140, 460);        
  }
  
  public void handleEvent(UIEventData uied) 
  {   
  
   if (uied.eventIsFromWidget("Value"))
    {
      float newValue = uied.sliderValue*255f;
      valueBox.setText(str(int(newValue))); 
      updateEffect(newValue);
      print("\n", newValue);
    }
    
    if(uied.eventIsFromWidget("Val"))
    {     
      float newValue = parseInt(trim(valueBox.contents));     
      valueSlider.setSliderValue(newValue);
      updateEffect(newValue);
      print("\n", newValue);
    }
    
    if(uied.eventIsFromWidget("Confirm")){ imageElement.setImage(newImage); ui.setEnabled(false);}
    if(uied.eventIsFromWidget("Reset")) { imageElement.setImage(baseImage); }
  }
  
  protected void drawOther() 
  {
    image(newImage, imageElement.X+imageElement.CanvasX, imageElement.Y+imageElement.CanvasY);
  }
  
  protected void drawUI() 
  {
    ui.update();
  } 
  
}
