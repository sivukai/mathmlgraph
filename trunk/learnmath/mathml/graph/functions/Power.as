package learnmath.mathml.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Power extends GraphFunction{

	private var n1:GraphFunction;
	private var n2:GraphFunction;
	
	public function Power(_n1:GraphFunction, _n2:GraphFunction):void{
		n1 = _n1;
		n2 = _n2;
		getVariablesFrom(_n1);
		getVariablesFrom(_n2);
	}


	public override function calculate(value:Result):Result{
		if(hasException(value)) return value;
		
		var v1 = n1.calculate(value).calcValue;
		var v2 = n2.calculate(value).calcValue;

		value.calcValue = Math.pow(v1,v2);
		return value;
	}
	

	public override function toString():String{
		return "Pow{" + n1.toString() + ", " +  n2.toString() + "}";
	}


}
}