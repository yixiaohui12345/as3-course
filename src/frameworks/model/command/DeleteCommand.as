package frameworks.model.command 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import morn.core.components.law.EPage;
	/**
	 * ...
	 * @author yxh
	 */
	public class DeleteCommand extends CommandBase 
	{
		private var _Parent:DisplayObjectContainer;
        private var _Target:DisplayObject;
        private var _Index:int;
		
		public function DeleteCommand(parent:DisplayObjectContainer, target:DisplayObject)
		{
			_Parent = parent;
            _Target = target;
            _Index = _Parent.numChildren;
            if (_Parent.contains(_Target))
                _Index = _Parent.getChildIndex(_Target);
            _Title = "删除" + _Target.name;
		}
		
		override public function Execute():void
        {
			if (!_Parent.contains(_Target))
                return;
			if (_Parent is EPage)
			{
				EPage(_Parent).removeElement(_Target);
			}
            else
			{
				_Parent.removeChild(_Target);
			}
		}
		
		override public function UnExecute():void
        {
            if (_Parent.contains(_Target))
                return;
            if (_Parent is EPage)
			{
				EPage(_Parent).addElement(_Target,_Target.x,_Target.y);
			}
			else
			{
				_Parent.addChild(_Target);
			}
        }
		
		override protected function Disposing():void
        {
            _Parent = null;
            _Target = null;
            super.Disposing();
        }
	}

}