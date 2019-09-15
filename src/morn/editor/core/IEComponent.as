package morn.editor.core 
{
	import flash.geom.Rectangle;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author yxh
	 */
	public interface IEComponent 
	{
		//是否被选中
		function set isSelected(value:Boolean):void;
		function get isSelected():Boolean;
		
		//复制所需属性
		function get attribute():Object;
		
		//右键菜单数组
		function get menus():Array;
		function set menus(value:Array):void;
		
		//自身组件描述xml
		function get exml():XML
		
		//初始化属性
		function get starter():Object;
		
		//回滚
		function backStarter():void
	}
	
}