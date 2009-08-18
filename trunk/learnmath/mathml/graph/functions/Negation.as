package learnmath.mathml.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Negation extends GraphFunction{

	private var c:GraphFunction;

	public function Negation(child:GraphFunction):void{
		c = child;
		getVariablesFrom(child);
	}


	public override function calculate(value:Result):Result{
		if(hasException(value)) return value;

		value.calcValue = -c.calculate(value).calcValue;
		return value;
	}
	

	public override function toString():String{
		return "-" + c.toString();
	}

}
}