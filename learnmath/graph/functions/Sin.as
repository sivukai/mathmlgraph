package learnmath.graph2d.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Sin extends GraphFunction{

	private n1:GraphFunction;
	
	public function Sin(_n1:GraphFunction):void{
		n1 = _n1;
		getVariablesFrom(_n1);
	}


	public function calculate(value:Result):Result{
		if(hasException(value)) return value;

		if(n1==null) return 0;
		
		var v1 = n1.calculate(value).calcValue;

		value.calcValue = Math.sin(v1);
		return value;
	}
	

	public function toString():String{
		return "Power";
	}


}
}