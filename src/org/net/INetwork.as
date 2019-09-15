package org.net 
{
	
	/**
	 * ...
	 * @author yxh
	 */
	public interface INetwork 
	{
		function set connected(url:Boolean):void;
		function get connected():Boolean;
		function onNetworkChange():void;
	}
	
}