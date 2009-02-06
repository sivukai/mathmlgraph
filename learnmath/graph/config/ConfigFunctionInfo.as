package learnmath.graph.config{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class ConfigFunctionInfo{

	public function ConfigFunctionInfo():void{
		setDefault();
	}
	
	public function setDefault():void{
			
	}



	public function getCopy():ConfigFunctionInfo{
		var c:ConfigFunctionInfo = new ConfigFunctionInfo();
		return c;		
	}

}
}