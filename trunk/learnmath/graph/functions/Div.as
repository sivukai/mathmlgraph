package learnmath.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Div extends GraphFunction{

	private var n1:GraphFunction;
	private var n2:GraphFunction;
	
	public function Div(_n1:GraphFunction, _n2:GraphFunction):void{
		n1 = _n1;
		n2 = _n2;
		getVariablesFrom(_n1);
		getVariablesFrom(_n2);
	}


	public override function calculate(value:Result):Result{
		if(hasException(value)) return value;

		if(n1==null || n2==null){
			value.exception = "EXCEPTION";
			return value;
		}
		
		var v1 = n1.calculate(value).calcValue;
		var v2 = n2.calculate(value).calcValue;
		if(v2==0) {
			value.calcValue = 0;
			if(v1<0){
				value.exception = "INFINITY"
			}else{
				value.exception = "-INFINITY"
			}
		}else{
			value.calcValue = v1/v2;
		}
		return value;
	}
	

	public override function toString():String{
		return "Div";
	}


}
}