package learnmath.mathml.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Cos extends GraphFunction{

	private var n1:GraphFunction;
	
	public function Cos(_n1:GraphFunction):void{
		n1 = _n1;
		getVariablesFrom(_n1);
	}


	public override function calculate(value:Result):Result{
		if(hasException(value)) return value;

		if(n1==null){
			value.calcValue = 0;
			return value;
		}
		
		var v1 = n1.calculate(value).calcValue;

		value.calcValue = Math.cos(v1);
		return value;
	}
	

	public override function toString():String{
		return "cos(" + n1.toString()+")";
	}


}
}