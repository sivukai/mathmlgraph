package learnmath.mathml.graph.config{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.strokes.*;

public class ConfigurationManager{


	public static function getConfig():ConfigAppInfo{
		var configAppInfo:ConfigAppInfo = new ConfigAppInfo();
		//JavaScriptConfig.init(configAppInfo);
		//FlashVarsConfig.init(configAppInfo);
		//XMLConfig.init(configAppInfo);
		//MenuConfig.init(configAppInfo);
		return configAppInfo;
	}



}
}