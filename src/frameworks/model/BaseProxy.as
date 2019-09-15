package frameworks.model 
{
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import org.net.HttpJson
	import org.net.HttpRequest;
	import org.net.IClient;
	import org.net.INetwork
	import mvcexpress.mvc.Proxy;
	/**
	 * ...
	 * @author yxh
	 */
	public class BaseProxy extends Proxy implements IClient
	{
		protected var httpClient:HttpJson = null;
		
		protected var request:HttpRequest = null;
		
		protected var requsetCode:int = 0;
		
		protected var syncHandle:Function = null
		
		protected var isSync:Boolean = false;
		
		public function BaseProxy() 
		{
			httpClient = new HttpJson();
			httpClient.client = this;
			request = new HttpRequest();
		}
		
		/**
		 * 
		 * @param	url
		 * @param	variables
		 * @param	method
		 * @param	timeOut
		 */
		public function sendRequest(url:String,variables:URLVariables=null,args:Array=null, method:String = URLRequestMethod.POST, timeOut:int = 15):void
		{
			httpClient.timeOut = timeOut;
			httpClient.send(request.getRequest(url, variables, method),args);
		}
		
		private var _connected:Boolean = false;
		public function get connected():Boolean { return _connected };
		public function set connected(value:Boolean):void
		{
			this._connected = value;
		}
		
		private var _responseContent:Object = null;
		public function get responseContent():Object { return this._responseContent };
		public function set responseContent(value:Object):void
		{ 
			this._responseContent = value 
		};
	
		private var _jsonContent:Object = null;
		public function get jsonContent():Object { return this._jsonContent };
		public function set jsonContent(value:Object):void
		{ 
			this._jsonContent = value 
		};
		
		public function onSuccess(args:Array):void
		{
		}
		
		public function onTimeOut(args:Array):void
		{
		}
		
		public function onFailed(args:Array):void
		{
		}
		
		public function cancel():void
		{
			trace("取消请求");
			if (httpClient)
			{
				httpClient.cancel();
			}
		}
	}

}