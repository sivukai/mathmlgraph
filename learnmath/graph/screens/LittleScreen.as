package learnmath.graph.screens{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.display.*;
import learnmath.graph.*;
import learnmath.graph.coordinates.*;


public class LittleScreen extends Screen{

	public function LittleScreen(_graphManager:Graph2DManager, width:int, height:int, pannel:Sprite){
		super(_graphManager, width, height, pannel);
	}

	public override function toString():String{
		return "LittleScreen !!!";
	}

}
}