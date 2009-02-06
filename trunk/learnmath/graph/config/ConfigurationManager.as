package learnmath.graph.config{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.strokes.*;

public class ConfigurationManager{

	private static var configAppInfo:ConfigAppInfo;


	public static function getConfig():ConfigAppInfo{
		if(configAppInfo==null){
			configAppInfo = new ConfigAppInfo();
			JavaScriptConfig.init(configAppInfo);
			FlashVarsConfig.init(configAppInfo);
			XMLConfig.init(configAppInfo);
			MenuConfig.init(configAppInfo);
		}
		return configAppInfo;
	}



	public static function getStyleForSelection():StrokeStyle{
		return getConfig().getStyleForSelection();
	}

	public static function getStyleForCoordinates():StrokeStyle{
		return getConfig().getStyleForCoordinates();
	}

}
}