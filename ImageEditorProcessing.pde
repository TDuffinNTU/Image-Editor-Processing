ImageEditor editorUI;
NewDocument newdocumentUI;
ThresholdUI thresholdUI;
OpacityUI opacityUI;

Artboard ab;

ArrayList<SimpleUIWrapper> uiList;

void setup() 
{
  size(1000,1000);
  uiList = new ArrayList<SimpleUIWrapper>();
  
  editorUI = new ImageEditor();
  uiList.add(editorUI);
  
  newdocumentUI = new NewDocument();
  uiList.add(newdocumentUI);
  
  thresholdUI = new ThresholdUI();
  uiList.add(thresholdUI);
  
  opacityUI = new OpacityUI();
  uiList.add(opacityUI);
}



void draw()
{
  for(SimpleUIWrapper uiw : uiList) {
    uiw.drawMe();
  }
  
}

void handleUIEvent(UIEventData uied)
{
 for(SimpleUIWrapper uiw : uiList) {
    if (uiw.ui.UIManagerName == uied.callingUIManager) uiw.handleEvent(uied);
  }  
}
