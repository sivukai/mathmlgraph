package learnmath.windows.apps{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.*;
import learnmath.windows.elements.*;
import learnmath.windows.*;
import learnmath.windows.menu.*;
import flash.display.*;
import fl.containers.*;
import flash.net.*;
import flash.events.*;
import learnmath.mathml.graph.coordinates.*;
import flash.geom.*;

public class GraphApp extends WindowXP{

	var menuBar:MenuBar;
	var toolbars:ToolbarsBean;
	var graph:MovieClip;
	var graphWorkspace:GraphWorkspace;
	public var sp:ScrollPane;
	
	var workingPannelW;
	var workingPannelH;
	
	var toolbarsManager:Toolbars = new Toolbars();
	

	public function GraphApp(parent:MovieClip, x:int, y:int, _width:int, _height:int){
		name = "MathML Graph";
		super(parent, new LittleIconGraphMC(), x, y, _width, _height);
		this.pannel.addEventListener(ToolbarCustomEvent.EXECUTE, showToolbars);

		
		graph = new MovieClip();
		graphWorkspace = new GraphWorkspace();
		graphWorkspace.createWorkspace(graph, _width-7, _height-85)
		
		sp = new ScrollPane();
		sp.source = graph;
		
		//create the menu
		menuBar = new MenuBar();
		toolbars = new ToolbarsBean();
		ToolbarMenuGraph.init(menuBar, toolbars);
	}
	
	public override function redrawWorkingPannel():void {
		workingPannelW = pannel.width-6;
		workingPannelH = pannel.height-20-22-22-1; // sustract title bar,  menu bar, status bar height

		pannel.addChild(sp);
		var toolbarContainer:ToolbarContainer = MenuManager.createToolbars(this, pannel, toolbars, 3, 21+22, workingPannelW, workingPannelH);
		toolbarContainer.pannel.addEventListener(RedrawToolbarsEvent.REDRAW, redraw);

		var menuBarPannel:MenuBarPannel = MenuManager.createMenu(pannel, menuBar, workingPannelW);
		menuBarPannel.pannel.addEventListener(MenuCustomEvent.EXECUTE, executeMenu);
		menuBarPannel.pannel.x = 3;
		menuBarPannel.pannel.y = 21; // add title bar
		
		workingPannelW = workingPannelW - (toolbarContainer.getWidthLeft() + toolbarContainer.getWidthRight());
		workingPannelH = workingPannelH - (toolbarContainer.getHeightTop()  + toolbarContainer.getHeightBottom()) ; 
		
		sp.move(3 + toolbarContainer.getWidthLeft(), menuBarPannel.pannel.y + menuBarPannel.pannel.height + toolbarContainer.getHeightTop()-1);
		sp.setSize(workingPannelW, workingPannelH);

		toolbarsManager.redrawToolbars(pannel);
	}
	
	public function redraw(event:RedrawToolbarsEvent):void {
		super.draw();
	}	
	
	public override function redrawStatusBar(_statusBox:StatusBox):void {
		_statusBox.setHtml("<p align='right'><b>MathML Graph - www.learn-math.info</b></p>");
	}	
	
	public override function drawOnFrame():void {
		graphWorkspace.drawOnFrame();
	}

	public function zoomOutTheDomain():void {
		graphWorkspace.zoomOutTheDomain();
	}

	public override function processKey(e:KeyboardEvent):void {
		graphWorkspace.keyReleased(e);
	}

	public function addFunction(mathml:String):void {
		graphWorkspace.addFunction(mathml);
	}

	public function showToolbars(event:ToolbarCustomEvent):void {
		trace("event toolbar:" + event.menuId + " value:" + event.value);
		if(event.menuId=="toolbar_zoom_in"){
			graphWorkspace.zoomInTheDomain();
		}else if(event.menuId=="toolbar_zoom_out"){
			graphWorkspace.zoomOutTheDomain();
		}else if(event.menuId=="toolbar_zoom_reset"){
			graphWorkspace.moveToOrigin();
		}else if(event.menuId=="toolbar_cartesian2D"){
			graphWorkspace.setCoordinate( new Cartesian2D());
		}else if(event.menuId=="toolbar_polar2D"){
			graphWorkspace.setCoordinate( new Polar2D());
		}
	}

}
}