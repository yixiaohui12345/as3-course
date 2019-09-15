package morn.editor.core 
{
	
	/**
	 * ...
	 * @author yxh
	 */
	public interface ICommand 
	{
		function undo():void;
		
		function redo():void;
	}
	
}