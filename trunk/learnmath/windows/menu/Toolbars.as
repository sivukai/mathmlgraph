package learnmath.windows.menu{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.display.*;
import learnmath.windows.elements.*;
import flash.events.*;

public class Toolbars{

	public var listPannels:Array = new Array();
	
	public function redrawToolbars(pannel:MovieClip):void{
		for (var key in listPannels){
			var tPannel:ToolsPannel = ToolsPannel(listPannels[key]);	
			if(tPannel!=null){
				pannel.addChild(tPannel.pannel);
			}
		}
	}

	public function drawToolbar(pannel:MovieClip, toolbarId:String, x:int, y:int):void{
		//for (var key in listPannels){
		//	var p:ToolsPannel = ToolsPannel(listPannels[key]);	
		//	if(p!=null && !p.haveBeenMoved){
		//		p.pannel.parent.removeChild(p.pannel);
		//		listPannels[key] = null;
		//	}
		//}
		//var tPannel:ToolsPannel = ToolsPannel(listPannels[toolbarId]);
		//if(tPannel == null){
		//	tPannel = new ToolsPannel(pannel, "", toolbarId, x, y, toolbars[toolbarId], values[toolbarId]);
		//	tPannel.draw();
		//	tPannel.bClose.pannel.addEventListener(MouseEvent.CLICK, closeWindow);
		//	listPannels[toolbarId] = tPannel;
		//}
		
	}

	function closeWindow(event:MouseEvent):void {
		var toolbarId = event.target.panelId;
		var window = listPannels[toolbarId];
		window.pannel.parent.removeChild(window.pannel);
		listPannels[toolbarId] = null;
	}	



}

}