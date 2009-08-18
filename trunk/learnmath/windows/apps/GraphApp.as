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
		
		graph = new MovieClip();
		graphWorkspace = new GraphWorkspace();
		graphWorkspace.createWorkspace(graph, _width-9, _width-76)
		
		sp = new ScrollPane();
		sp.source = graph;
		
		//create the menu
		menuBar = new MenuBar();
		var m1:MenuGroup = new MenuGroup("File", "menu_file");
		m1.addMenuList(new MenuItem("New", "menu_file_new"));
		m1.addMenuList(new MenuItem("Open...", "menu_file_open"));
		m1.addMenuList(new MenuItem("Save", "menu_file_save"));
		m1.addMenuList(new MenuItem("Close", "menu_file_close"));
		menuBar.addMenuList(m1);
		
		var m2:MenuGroup = new MenuGroup("Edit", "menu_edit");
		m2.addMenuList(new MenuItem("Undo", "menu_edit_undo"));
		m2.addMenuList(new MenuItem("Redo", "menu_edit_redo"));
		m2.addMenuList(new MenuItem("Cut", "menu_edit_cut"));
		m2.addMenuList(new MenuItem("Copy", "menu_edit_copy"));
		m2.addMenuList(new MenuItem("Paste", "menu_edit_paste"));		
		menuBar.addMenuList(m2);

	
		var m5:MenuGroup = new MenuGroup("Help", "menu_help");
		m5.addMenuList(new MenuItem("Commands", "menu_help_comm"));
		m5.addMenuList(new MenuItem("MathML", "menu_help_mathml"));
		m5.addMenuList(new MenuItem("About MathML Editor...", "menu_help_about"));
		menuBar.addMenuList(m5);
		
		toolbars = new ToolbarsBean();
		var tool2:ToolbarBean = new ToolbarBean();
		tool2.addElement(new NewIcon(18, 19), "menu_file_new", true);
		tool2.addElement(new OpenIcon(19, 19), "menu_file_open", true);
		tool2.addElement(new SaveIcon(18, 19), "menu_file_save", false);
		tool2.addSpace();
		toolbars.addToolbar(tool2);

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

	public function addFunction(mathml:String):void {
		graphWorkspace.addFunction(mathml);
	}

}
}