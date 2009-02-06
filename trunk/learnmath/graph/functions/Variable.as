package learnmath.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Variable extends GraphFunction{

	private var v:Number = 0;
	public var name:String = "x";

	public function Variable(_name:String):void{
		name = _name;
	}


	public function setValue(value:Number):void{
		v = value;
	}
	

	public override function calculate(value:Result):Result{
		value.calcValue = v;
		return value;
	}
	

	public override function toString():String{
		return name ;
	}


}
}