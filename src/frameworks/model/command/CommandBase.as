package frameworks.model.command 
{
	/**
	 * ...
	 * @author yxh
	 */
	public class CommandBase implements ICommand
	{
		
		public function CommandBase() 
		{
			
		}
		
		protected var _Title:String;
        public function get Title():String
        {
            return _Title;
        }
		
        public function Execute():void
        {
            throw new Error("Not implementation.");
        }
		
        public function UnExecute():void
        {
            throw new Error("Not implementation.");
        }
		
        private var _Disposed:Boolean = false;
		
        protected function Disposing():void
        {
			
        }
        public function Dispose():void
        {
            if (_Disposed)
                return;
            Disposing();
            _Disposed = true;
        }
		
	}

}