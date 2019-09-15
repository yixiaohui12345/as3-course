package org.net 
{
	
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author ...
	 */
	public class HttpClient extends URLLoader
	{
		public var request:URLRequest = null;
		/**
		 * 死锁状态
		 */
		public var islockStatus:Boolean = false;
		
		private var _timeOut:int = 10;
		
		private var _timeOutDuration:int = 3;
		
		private var timeId:int = -1;
		
		private var _isStartDataSync:Boolean = false;
		
		private var _syncFunc:Function = null;
		
		private var _revFunc:Function = null;
		
		protected var variables:URLVariables = null;
		
		public function HttpClient() 
		{
			
		}
		
		/**
		 * 重新请求
		 */
		public function reload():void
		{
			                                                                      
		}
		
		/**
		 * 发送请求
		 */
		public function send(request:URLRequest,args:Array=null):void
		{
			
		}
		
		/**
		 * 取消请求
		 */
		public function cancel():void
		{
			
		}
		
		private var timer:Timer = null;
		protected function startTimer():void
		{
			timer = new Timer(1000, timeOut);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
		}
		
		private function timerComplete(e:TimerEvent):void 
		{
			onTimeOut();
		}
		
		protected function stopTimer():void
		{
			if (timer)
			{
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeOut);
				timer.stop();
				timer.reset();
				timer = null;
			}
		}
		
		protected function onTimeOut():void
		{
			
		}
		
		protected function requestToString():String
		{
			if (request&&request.data != null&&request.data.requestContent)
			{
				return request.data.requestContent;
			}
			else if(request)
			{
				return request.url;
			}
			return null;
		}
		
		/**
		 * 超时时间(默认时间是5秒)
		 */
		public function get timeOut():int { return this._timeOut };
		public function set timeOut(value:int):void
		{
			this._timeOut = value;
		}
		
		/**
		 * 超时重新请求次数
		 */
		public function get timeOutDuration():int { return this._timeOutDuration };
		public function set timeOutDuration(value:int):void
		{
			this._timeOutDuration = value;
		}
		
		/**
		 * 是否同步数据
		 */
		public function get isStartDataSync():Boolean { return this._isStartDataSync };
		public function set isStartDataSync(value:Boolean):void
		{
			this._isStartDataSync = value;
		}
		
		/**
		 * 同步数据回调方法
		 */
		public function get syncFunc():Function { return this._syncFunc };
		public function set syncFunc(value:Function):void
		{
			this._syncFunc = value;
		}
		
		/**
		 * 请求回调函数
		 */
		public function get revFunc():Function { return this._revFunc };
		public function set revFunc(value:Function):void
		{
			this._revFunc = value;
		}
		
		private var _client:IClient = null;
		public function get client():IClient { return this._client };
		public function set client(value:IClient):void { this._client = value };
	}

}