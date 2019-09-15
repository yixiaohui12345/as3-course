package frameworks.model.command 
{
	import mx.collections.ArrayCollection;
	/**
	 * ...
	 * @author yxh
	 */
	public class MultiCommand extends CommandBase
	{
		private var _Commands:ArrayCollection
		
		public function MultiCommand(commands:ArrayCollection) 
		{
			_Commands = commands;
            if (_Commands.length > 0)
                _Title = ICommand(_Commands[0]).Title + "...";
		}
		
		override public function Execute():void
        {
			for (var i:int = 0, n:int = _Commands.length; i < n; i++)
			{
				_Commands.getItemAt(i).Execute();
			}
        }
        override public function UnExecute():void
        {
            for (var i:int = 0, n:int = _Commands.length; i < n; i++)
			{
				_Commands.getItemAt(i).UnExecute();
            }
        }
        override protected function Disposing():void
        {
			DisposeUtil.Dispose(_Commands);
            super.Disposing();
        }
	}

}