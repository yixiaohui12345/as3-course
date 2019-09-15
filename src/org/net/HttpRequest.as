package org.net 
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HttpRequest extends Object
	{
		private var request:URLRequest = null;
		
		public function HttpRequest() 
		{
			request = new URLRequest();
		}
		
		/**
		 * 
		 * @param	url
		 * @param	requestContent
		 * @param	method
		 * @param	useCache
		 * @param	cacheResponse
		 * @param	manageCookies
		 * @return
		 */
		public function getRequest(url:String, variables:URLVariables = null, method:String = URLRequestMethod.POST,
														useCache:Boolean=false,cacheResponse:Boolean=false,manageCookies:Boolean=false):URLRequest
		{
			request.url = url;
			request.method = method;
			variables && (request.data = variables);
			variables = null;
			return request;
		}
	}

}