public class SimpleUIWrapper {
  SimpleUI ui;  
  
  public SimpleUIWrapper(String uiname, boolean enabled) { ui = new SimpleUI(uiname, enabled);  }
  public SimpleUIWrapper() { ui = new SimpleUI(true);  }
  
  public void drawMe() {  if (!ui.getEnabled()) return; pushStyle();  drawOther(); drawUI(); popStyle();  }
  
  public void handleEvent(UIEventData uied) {}  
  
  protected void setupUI() {} // Virtual
  protected void drawOther() {} // Virtual
  
  protected void drawUI() {  ui.update();  }
}

SimpleUIWrapper getUI(String uiname) 
{
  for(SimpleUIWrapper ui : uiList)
  {
    if (ui.ui.getUIManagerName() == uiname) return ui;
  }
  
  
  print("ERROR, NAME MISSMATCH, PROVIDED ARGUMENT: ", uiname);
  print("UILIST CONTENTS: ");
  for(SimpleUIWrapper ui : uiList) {
    print(ui.ui.getUIManagerName(), ",");
  }
  return null;
}
