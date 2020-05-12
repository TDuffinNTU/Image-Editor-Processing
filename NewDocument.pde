public class NewDocument extends SimpleUIWrapper 
{
  TextInputBox widthInput, heightInput;
  //SimpleUI imageEditor;
  int W_MINIMUM = 800;
  int H_MINIMUM = 600;
  
  public NewDocument() 
  {    
    super("NewDocument", true);
    //imageEditor = ieui;
    setupUI();
  }
  
  protected void setupUI() 
  {
    //ui = new SimpleUSimpleButton(I(true);
    ui.addLabel("Create New Document", 110, 110, "");
    
    widthInput = ui.addTextInputBox("Width(px)", 110, 160);
    heightInput = ui.addTextInputBox("Height(px)", 110, 200);
    
    ui.addToggleButton("Create", 110, 260);
    ui.addToggleButton("Cancel", 230, 260);
  }
  
  public void handleEvent(UIEventData uied) 
  {    
    if (uied.eventIsFromWidget("Create"))   
    {
      int w = parseInt(trim(widthInput.contents));
      int h = parseInt(trim(heightInput.contents));     
      
      if(w < W_MINIMUM || h < H_MINIMUM) {
      
      }
      else {
        ui.setEnabled(false);
        ImageEditor ieui = (ImageEditor)getUI("ImageEditor");  
        ieui.SetDocumentSize(w, h);
      }
      
      
    }
    if (uied.eventIsFromWidget("Cancel")) 
    {
      ui.setEnabled(false);
    }
    
  }
  
  protected void drawOther() 
  {
    pushStyle();
    fill(80);
    noStroke();
    rect(100, 110, 400, 200);
    popStyle();
  }
  
  protected void drawUI() 
  {
    ui.update();
  }
  
}
