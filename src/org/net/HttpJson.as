package org.net 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author ...
	 */
	public class HttpJson extends HttpClient
	{
		protected var args:Array = null;
		
		public function HttpJson() 
		{
			super();
			addEventListener(Event.COMPLETE, onComplete);
			addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
			addEventListener(Event.OPEN, onOpen);
		}
		
		override public function reload():void
		{
			islockStatus = true;
			super.load(request);
			super.startTimer();
		}
		
		override public function send(_request:URLRequest,_args:Array=null):void
		{
			if (_request == null)
			{
				throw new ArgumentError("request 参数为null");
				return;
			}
			if (islockStatus)
			{
				return
			}
			if (this.args)
			{
				this.args.length = 0;
				this.args = null;
			}
			
			requestTimes = 0;
			this.request = _request;
			this.args = _args;
			
			islockStatus = true;
			super.load(request);
			super.startTimer();
		}
		
		override public function cancel():void
		{
			try
			{
				islockStatus = false;
				super.stopTimer();
				super.close();
			}
			catch (evt:Error)
			{
				
			}
		}
		
		private var requestTimes:int = 0;
		override protected function onTimeOut():void
		{
			islockStatus = false;
			//取消请求
			cancel();
			//停止计时器
			super.stopTimer();
			if (requestTimes>=timeOutDuration)
			{
				if (this.client != null)
				{
					this.client.onFailed(args);
				}
				return 
			}
			else
			{
				requestTimes++;
				//重新请求
				reload();
			}
		}
		
		private function onOpen(e:Event):void {}
		
		private function onHttpStatus(e:HTTPStatusEvent):void {}
		
		private function onSecurityError(e:SecurityErrorEvent):void 
		{
			islockStatus = false;
			super.stopTimer();
			if (this.client != null)
			{
				this.client.onFailed(args);
			}
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace(e.toString());
			islockStatus = false;
			super.stopTimer();
			if (this.client != null)
			{
				this.client.onFailed(args);
			}
		}
		
		private function onComplete(e:Event):void 
		{
			islockStatus = false;
			super.stopTimer();
			trace(e.target.data);
			if (this.client != null)
			{
				//回调处理数据方法
				client.responseContent = e.target.data;
				client.jsonContent = JSONUtils.decode(e.target.data);
				client.onSuccess(args);
			}
		}
	}

}