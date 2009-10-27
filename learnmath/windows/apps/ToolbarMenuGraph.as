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

public class ToolbarMenuGraph {

	public static function init(menuBar:MenuBar, toolbars:ToolbarsBean){
		//create the menu
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
		
		var tool2:ToolbarBean = new ToolbarBean();
		tool2.addElement(new NewIcon(18, 19), "menu_file_new", true);
		tool2.addElement(new OpenIcon(19, 19), "menu_file_open", true);
		tool2.addElement(new SaveIcon(18, 19), "menu_file_save", false);
		tool2.addSpace();
		toolbars.addToolbar(tool2);
		
		var tool3:ToolbarBean = new ToolbarBean();
		tool3.addElement(new ZoomIn(19, 19), "toolbar_zoom_in", true);
		tool3.addElement(new ZoomOut(19, 19), "toolbar_zoom_out", true);
		tool3.addSpace();
		tool3.addElement(new ZoomCenter(19, 19), "toolbar_zoom_reset", true);
		tool3.addSpace();
		toolbars.addToolbar(tool3);

		var tool4:ToolbarBean = new ToolbarBean();
		tool4.addElement(new Cartesian2DIcon(19, 19), "toolbar_cartesian2D", true);
		tool4.addElement(new Polar2DIcon(19, 19), "toolbar_polar2D", true);
		tool4.addSpace();
		toolbars.addToolbar(tool4);

	}
}
}