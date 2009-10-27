package learnmath.mathml.graph.util{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.events.*;
import flash.display.*;
import flash.text.*;


public class DrawUtil{

	public static function dashLine(g:Sprite, x1:Number, y1:Number, x2:Number, y2:Number, onLength:Number = 3, offLength:Number = 3):void {
		g.graphics.moveTo(x1,y1);
		if (offLength==0) {    
			g.graphics.lineTo(x2,y2);    
			return;
		}
		
		var dx:Number = x2-x1,    
			dy:Number = y2-y1,    
			lineLen:Number = Math.sqrt(dx*dx + dy*dy),    
			angle:Number = Math.atan2(dy, dx),    
			cosAngle:Number = Math.cos(angle),    
			sinAngle:Number = Math.sin(angle),    
			ondx:Number  = cosAngle*onLength,    
			ondy:Number  = sinAngle*onLength,    
			offdx:Number = cosAngle*offLength,    
			offdy:Number = sinAngle*offLength,    
			x:Number = x1,    
			y:Number = y1;
		
		var fullDashCountNumber:int = Math.floor(lineLen/(onLength+offLength));
		for (var i:int=0; i<fullDashCountNumber; i++){       
			g.graphics.lineTo(x+=ondx,y+=ondy);     
			g.graphics.moveTo(x+=offdx,y+=offdy);    
		}    
		
		var remainder:Number = lineLen - ((onLength+offLength)*fullDashCountNumber);    
		if (remainder>=onLength) {    
			g.graphics.lineTo(x+=ondx,y+=ondy);    
		} else {        
			g.graphics.lineTo(x2,y2);    
		}
	}
	

  	/*
  	*	g    Displayobject to add the textfield to. 
  	*	col    Color of the text. 
  	*	xps    X offset of the rectangle. 
  	*	yps    Y offset of the rectangle.
  	*	txt    Text string to print. 
  	*	ats    Textfield autosize direction, defaults to left. 
  	* 	siz    Font size, defaults to 12. 
  	*/
         public static function drawText(g:Sprite, col:Number, xps:Number, yps:Number, txt:String, ats:String='left', siz:Number=12, fnt:String='Arial'):TextField { 
                 var tfd:TextField = new TextField(); 
                 var fmt:TextFormat = new TextFormat(); 
                 tfd.autoSize = ats; 
                 tfd.selectable = false; 
                 fmt.font = fnt; 
                 fmt.color = col; 
                 fmt.size = siz; 
                 fmt.underline = false; 
                 tfd.defaultTextFormat = fmt; 
                 tfd.x = xps; 
                 tfd.y = yps; 
                 tfd.text = txt; 
                 g.addChild(tfd); 
                 return tfd; 
        }; 
		
	public static function getWidth(text:String, siz:Number=12, fnt:String='Arial'):Number{
		var tfield:TextField = new TextField();
		var fmt:TextFormat = new TextFormat(); 
		fmt.font = fnt; 
        fmt.size = siz; 
        fmt.underline = false; 
		tfield.defaultTextFormat = fmt;
		tfield.text = text;
		return tfield.getLineMetrics(0).width;
	}
	

}
}