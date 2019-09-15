package frameworks.message 
{
	import frameworks.model.PageConfig;
	import frameworks.model.command.DisposeUtil;
	/**
	 * ...
	 * @author yxh
	 */
	public class EffectConfig 
	{
		public static const LIST:Array=["x轴翻转淡入","y轴翻转淡入","淡入","向上淡入","向下淡入","左边淡入","右边淡入","向上滑入","向下滑入","左边滑入","右边滑入"]
		
		
		public static var ANI:Array = [{duration:1, vars:{rotationX:90, alpha:0,delay:0}},
												  {duration:1, vars:{rotationY:90, alpha:0,delay:0}},
												  {duration:1, vars:{alpha:0,delay:0}},
												  {duration:1, vars:{y:PageConfig.PAGE_HEIGHT, alpha:0,delay:0}},
												  {duration:1, vars:{y: -PageConfig.PAGE_HEIGHT, alpha:0,delay:0}},
												  {duration:1, vars:{x: -PageConfig.PAGE_WIDTH, alpha:0,delay:0}},
												  {duration:1, vars:{x:PageConfig.PAGE_WIDTH, alpha:0,delay:0}},
												  {duration:1, vars:{y:PageConfig.PAGE_HEIGHT,delay:0}},
												  {duration:1, vars:{y: -PageConfig.PAGE_HEIGHT,delay:0}},
												  {duration:1, vars:{x: -PageConfig.PAGE_WIDTH,delay:0}},
												  {duration:1, vars:{x:PageConfig.PAGE_WIDTH, delay:0}} ];
		
		
		
		public function EffectConfig() 
		{
			
			
		}
		
		private static var _inst:EffectConfig = null;
		public static function get inst():EffectConfig
		{
			if (_inst == null)
			{
				_inst = new EffectConfig();
			}
			return _inst;
		}
		
		
		
		
	}

}