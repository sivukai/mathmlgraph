package learnmath.graph{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.*;
import flash.display.*;
import flash.geom.*;
import fl.controls.*;
import flash.events.*;


public class GraphWorkspace{

	var graphManager:Graph2DManager;
	var startSelecting:Boolean = false;
	var beginPoint:Point = new Point();
	var endPoint:Point = new Point();
	public var containerSelection:Sprite;
	
	public function createWorkspace(parent:MovieClip, width:int, height:int):MovieClip{
		graphManager = new Graph2DManager(this);
		var graphMovieClip:MovieClip = new MovieClip();
		
		createSpecWorkspace(graphMovieClip, width, height);
		parent.addChild(graphMovieClip);
		return graphMovieClip;
	}
	
	function createSpecWorkspace(parent:MovieClip, width:int, height:int):void{
		var bigPannel:MovieClip = new MovieClip();
		bigPannel.graphics.lineStyle(1,0xffffff);
		bigPannel.graphics.beginFill(0xffffff);   
		bigPannel.graphics.drawRect(0, 0, width-1, height-1);   
		bigPannel.graphics.endFill();
		parent.addChild(bigPannel);

		//202/202
		var littleMovieClip = new LittleMovieClip();
		littleMovieClip.graphManager = graphManager;
		var container2:Sprite = new Sprite();
		littleMovieClip.littlePannel.addChild(container2);
		
		if(width<800){
			var factor = height/800;
			if(width<height){
				factor = width/800;
			}
			littleMovieClip.width = 202*factor;
			littleMovieClip.height = 202*factor;
		}
		littleMovieClip.x = 100*width/800;
		littleMovieClip.y = 70*height/800;
		parent.addChild(littleMovieClip);
		
		//300/121
		var textClip = new TextClip();
		if(width>=800){
			textClip.x = width - 200*width/800;
			textClip.y = height - 100*height/800;;
			parent.addChild(textClip);
		}


		var container:Sprite = new Sprite();
		bigPannel.addChild(container);
		
		
		containerSelection = new Sprite();
		bigPannel.addChild(containerSelection);
		
		bigPannel.doubleClickEnabled = true;
		bigPannel.addEventListener(MouseEvent.MOUSE_DOWN, startSelect);
		bigPannel.addEventListener(MouseEvent.MOUSE_MOVE, moveSelect);
		bigPannel.addEventListener(MouseEvent.MOUSE_UP, stopSelect);
		bigPannel.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickEvent);
		bigPannel.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		
		graphManager.init();
		graphManager.initBigScreen(width, height, container);
		graphManager.initLittleScreen(140, 140, container2);
		graphManager.initTextScreen(textClip.textArea);
		
		graphManager.drawInit();
	}

	function startSelect(event:MouseEvent):void {
		startSelecting = true;
		var point:Point = new Point(event.stageX, event.stageY);
		beginPoint = containerSelection.globalToLocal(point);
	}
	
	function moveSelect(event:MouseEvent):void {
		var point:Point = new Point(event.stageX, event.stageY);
		if(startSelecting){
			endPoint = containerSelection.globalToLocal(point);
			clearSelection();
			graphManager.drawSelection(containerSelection, beginPoint, endPoint);
		}
		var p = containerSelection.globalToLocal(point);
		graphManager.writePosition(p);
	}
	
	function stopSelect(evt:MouseEvent):void {
		startSelecting = false;
		graphManager.zoomInTheDomain();
		clearSelection();
	}
	
	function clearSelection():void {
			containerSelection.graphics.clear();
			while (containerSelection.numChildren){
				containerSelection.removeChildAt(0);
			}
	}
	
	function keyReleased(event:KeyboardEvent):void {
		graphManager.moveDomain(event.keyCode);
	}
	
	function doubleClickEvent(event:MouseEvent):void {
		var point:Point = new Point(event.stageX, event.stageY);
		var p = containerSelection.globalToLocal(point);
		graphManager.moveDomainTo(p);
	}

	public function drawOnFrame():void{
		graphManager.drawOnFrame();
	}
	
	public function addFunction(mathML:String):String{
		var val = graphManager.addFunction(mathML);
		graphManager.drawInit();
		return val;
	}

}
}