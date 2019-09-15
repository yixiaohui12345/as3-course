package frameworks.model.command 
{
	/**
	 * ...
	 * @author yxh
	 */
	public class EditCommand extends CommandBase
	{
		private var _Property:String;
        private var _Target:Object;
        private var _OldValue:Object;
        private var _NewValue:Object;
		
		public function EditCommand(property:String, target:Object, oldValue:Object, newValue:Object) 
		{
			_Property = property;
            _Target = target;
            _OldValue = oldValue;
            _NewValue = newValue;
            _Title = "编辑" + _Property;
		}
		
		override public function Execute():void
        {
            _Target[_Property] = _NewValue;
        }
        override public function UnExecute():void
        {
            _Target[_Property] = _OldValue;
        }
        override protected function Disposing():void
        {
            _Target = null;
            _OldValue = null;
            _NewValue = null;
            super.Disposing();
        }
	}

}