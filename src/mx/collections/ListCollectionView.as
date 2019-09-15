package mx.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	/**
	 * 基本的数组功能
	 * 移除了所有事件驱动，页面更新处理
	 * @author Admin
	 * 
	 */	
	public class ListCollectionView extends Proxy implements IList
	{
		
		public function ListCollectionView()
		{
		}
		
		private var _list:IList;
		
//		private var resourceManager:IResourceManager =
//			ResourceManager.getInstance();
		
		public function get list():IList
		{
			return _list;
		}
		
		public function set list(value:IList):void
		{
			if (_list != value)
			{
				var oldHasItems:Boolean;
				var newHasItems:Boolean;
				if (_list)
				{
					oldHasItems = _list.length > 0;
				}
				
				_list = value;
				
				if (_list)
				{
					newHasItems = _list.length > 0;
				}

			}
		}
		
		/**
		 * @inheritDoc 
		 */
		public function getItemAt(index:int, prefetch:int = 0):Object
		{
			if (index < 0 || index >= length)
			{
				var message:String = "Index "+index +" specified is out of bounds."
				throw new RangeError(message);
			}
			
			if (list)
			{
				return list.getItemAt(index, prefetch);
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function getItemIndex(item:Object):int
		{
			// fallback
			return list.getItemIndex(item);
		}
		
		/**
		 * @inheritDoc 
		 */
		public function setItemAt(item:Object, index:int):Object
		{	
			if (index < 0 || !list || index >= length)
			{
				var message:String = "Index "+index +" specified is out of bounds."
				throw new RangeError(message);
			}
			var listIndex:int = index;
			return list.setItemAt(item, listIndex);
		}
		
		/**
		 * @inheritDoc 
		 */
		public function removeItemAt(index:int):Object
		{	
			if (index < 0 || index >= length)
			{
				var message:String = "Index "+index +" specified is out of bounds."
				throw new RangeError(message);
			}
			var listIndex:int = index;
			return list.removeItemAt(listIndex);
		}
		
		/**
		 * Remove all items from the list.
		 */
		public function removeAll():void
		{
			var len:int = length;
			if (len > 0)
			{			
				list.removeAll();			
			}
		}
		
		/**
		 * @inheritDoc 
		 */
		public function toArray():Array
		{
			var ret:Array;
			ret = list.toArray();			
			return ret;
		}
		
		/**
		 *  Prints the contents of this view to a string and returns it.
		 * 
		 *  @return The contents of this view, in string form.
		 */
		public function toString():String
		{

			if (list && Object(list).toString)
				return Object(list).toString();
			else
				return getQualifiedClassName(this);

		}
		
		/**
		 * @inheritDoc 
		 */
		public function addItem(item:Object):void
		{
			addItemAt(item, length);
		}
		
		/**
		 * @inheritDoc 
		 */
		public function addItemAt(item:Object, index:int):void
		{	
			
			if (index < 0 || !list || index > length)
			{
				var message:String = "Index "+index +" specified is out of bounds."
				throw new RangeError(message);
			}
			
			var listIndex:int = index;
			list.addItemAt(item, listIndex);
		}
		
		/**
		 *  @inheritDoc
		 */
		public function get length():int
		{	
			if (list)
			{
				return list.length;
			}
			else
			{
				return 0;
			}
		}
		
		/**
		 *  @private
		 */
		override flash_proxy function nextValue(index:int):*
		{
			return getItemAt(index - 1);
		}  
		
		/**
		 *  @private
		 *  Any methods that can't be found on this class shouldn't be called,
		 *  so return null
		 */
		override flash_proxy function callProperty(name:*, ... rest):*
		{
			return null;
		}
		
		/**
		 *  @private
		 *  Attempts to call getItemAt(), converting the property name into an int.
		 */
		override flash_proxy function getProperty(name:*):*
		{
			if (name is QName)
				name = name.localName;
			
			var index:int = -1;
			try
			{
				// If caller passed in a number such as 5.5, it will be floored.
				var n:Number = parseInt(String(name));
				if (!isNaN(n))
					index = int(n);
			}
			catch(e:Error) // localName was not a number
			{
			}
			
			if (index == -1)
			{
				var message:String = " Unknown Property: "+[ name ];
//				var message:String = resourceManager.getString(
//				"collections", "unknownProperty", [ name ]);
				throw new Error(message);
			}
			else
			{
				return getItemAt(index);
			}
		}
		
		/**
		 *  @private
		 *  Attempts to call setItemAt(), converting the property name into an int.
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if (name is QName)
				name = name.localName;
			
			var index:int = -1;
			try
			{
				// If caller passed in a number such as 5.5, it will be floored.
				var n:Number = parseInt(String(name));
				if (!isNaN(n))
					index = int(n);
			}
			catch(e:Error) // localName was not a number
			{
			}
			
			if (index == -1)
			{
				var message:String = " Unknown Property: "+[ name ];
//				var message:String = resourceManager.getString(
//					"collections", "unknownProperty", [ name ]);
				throw new Error(message);
			}
			else
			{
				setItemAt(value, index);
			}
		}
		
		
	}
}