package frameworks.model.command 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import morn.core.components.law.EPage;
	/**
	 * ...
	 * @author yxh
	 */
	public class AddCommand extends CommandBase
	{
		private var _Parent:DisplayObjectContainer;
        private var _Target:DisplayObject;
        private var _Index:int;
		
		public function AddCommand(parent:DisplayObjectContainer,target:DisplayObject,index:Number=Number.NaN) 
		{
			_Parent = parent;
			_Target = target;
			_Index = isNaN(index)? _Parent.numChildren:index;
			if (_Parent.contains(_Target))
			{
				_Index = _Parent.getChildIndex(_Target);
			}
			_Title = "添加" + _Target.name;
		}
		
		override public function Execute():void
        {
			if(_Parent.contains(_Target))
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
		
		override public function UnExecute():void
        {
            if(!_Parent.contains(_Target))
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
		
		override protected function Disposing():void
        {
            _Parent = null;
            _Target = null;
            super.Disposing();
        }
	}

}