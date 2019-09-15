package morn.core.components.law 
{
	import morn.core.components.Component;
	
	/**
	 * ...
	 * @author yxh
	 */
	public interface IPlayer
	{
		function play():void;
		
		function stop():void;
		
		function pause():void;
		
		function resume():void;
		
		function hide():void;
		
		function show():void;
		
		function resize(pw:Number,ph:Number):void;
	}
	
}