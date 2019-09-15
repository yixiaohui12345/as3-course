package frameworks.model.command 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import frameworks.events.CompEvent;
	import morn.core.components.law.EPage;
	import mx.collections.ArrayCollection;
	/**
	 * ...
	 * @author yxh
	 */
	public class CommandManager extends EventDispatcher 
	{
		private static var g_Created:Boolean = false;
		
		private static var _inst:CommandManager = null;
		public static function get inst():CommandManager
		{
			if (_inst == null)
			{
				_inst = new CommandManager();
			}
			return _inst;
		}
		
		public function CommandManager() 
		{
			super();
            if (g_Created)
                throw new Error("Singleton class. Please use Instance static filed.");
            g_Created = true;
		}
		
		private var _UndoList:ArrayCollection = new ArrayCollection();
        private var _RedoList:ArrayCollection = new ArrayCollection();
		
		public function get CanRedo():Boolean
        {
            return _RedoList.length > 0;
        }
		
        public function get CanUndo():Boolean
        {
            return _UndoList.length > 0;
        }
		
		public function Redo():void
        {
            if (!CanRedo)
            {
				return;
			}
            var command:ICommand = _RedoList.removeItemAt(_RedoList.length - 1) as ICommand;
            command.Execute();
            _UndoList.addItem(command);
			dispatchEvent(new CompEvent(CompEvent.CHANGE_CMD));
        }
		
		public function Undo():void
        {
            if (!CanUndo)
            {
				return;
			}
            var command:ICommand = _UndoList.removeItemAt(_UndoList.length - 1) as ICommand;
            command.UnExecute();
            _RedoList.addItem(command);
			//trace("加入_RedoList-command")
			dispatchEvent(new CompEvent(CompEvent.CHANGE_CMD));
        }
		
		private function ExecuteCommand(command:ICommand):void
        {
            command.Execute();
            AppendCommand(command);
			
        }
        private function AppendCommand(command:ICommand):void
        {
            DisposeUtil.Dispose(_RedoList);
            _UndoList.addItem(command);
			//trace("AppendCommand"+command.Title)
			dispatchEvent(new CompEvent(CompEvent.CHANGE_CMD));
        }
		
		//======================添加、删除、编辑命令=============================
        public function Add(parent:DisplayObjectContainer, target:DisplayObject):void
        {
            var command:ICommand = new AddCommand(parent, target);
            ExecuteCommand(command);
        }
		
        public function Delete(parent:DisplayObjectContainer, target:DisplayObject):void
        {
            var command:ICommand = new DeleteCommand(parent, target);
            ExecuteCommand(command);
        }
		
        public function Edit(property:String, target:Object, oldValue:Object, newValue:Object):void
        {
            var command:ICommand = new EditCommand(property, target, oldValue, newValue);
            ExecuteCommand(command);
        }
		
		public function Multi(array:ArrayCollection):void
		{
			var command:ICommand = new MultiCommand(array);
			ExecuteCommand(command);
		}
		
		public function removeAll():void
		{
			DisposeUtil.Dispose(_UndoList);
			DisposeUtil.Dispose(_RedoList);
		}
	}

}