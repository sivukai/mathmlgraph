package learnmath.graph.strokes{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.util.*;

public class StrokeStyle{

	public static var colors:Array = new Array(0xff0000, 0x00ff00, 0x0000ff, 0xff8800, 0xff0088, 0x88ff00, 0x00ff88, 0x8800ff, 0x0088ff );
	static var r:RandomUtil = new RandomUtil(0, colors.length-1);

	public var color:Number = 0x000000;
	public var alpha:Number = 100;
	public var thin:Number = 1;
	

	public function copy():StrokeStyle{
		var newStyle = new StrokeStyle();
		newStyle.color = this.color;
		newStyle.alpha = this.alpha;
		newStyle.thin = this.thin;
		return newStyle;
	}
	
	public function setRandomColor():void{
		var index = r.nextNoRepeat();;
		color = colors[index];
	}
	
	
}
}