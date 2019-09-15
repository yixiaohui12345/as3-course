package morn.editor.core 
{
	
	/**
	 * ...
	 * @author yxh
	 */
	public interface IPage 
	{
		function playNext():Boolean;
		
		function playPre():Boolean;
		
		function get exml():XML;
	}
	
}