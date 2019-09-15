package org.net 
{
	
	/**
	 * ...
	 * @author yxh
	 */
	public interface IClient 
	{
		function set responseContent(value:Object):void;
		function get responseContent():Object;
		
		function set jsonContent(value:Object):void;
		function get jsonContent():Object;
		
		function onSuccess(args:Array):void;
		function onTimeOut(args:Array):void;
		function onFailed(args:Array):void;
	}
	
}