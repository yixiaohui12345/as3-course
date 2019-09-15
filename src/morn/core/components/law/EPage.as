package morn.core.components.law 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import frameworks.model.PageConfig;
	import morn.core.components.Box;
	import morn.core.components.Image;
	import morn.core.components.View;
	import morn.editor.core.IEComponent;
	import morn.core.events.UIEvent;
	import morn.editor.core.IPage;
	
	/**某个元素移动*/
	[UIEvent(name = "move", type = "morn.core.events.UIEvent")]
	/**删除某个元素*/
	[UIEvent(name = "delete", type = "morn.core.events.UIEvent")]
	/**选择触发*/
	[UIEvent(name="selectItem",type="morn.core.events.UIEvent")]
	/**
	 * ...
	 * @author yxh
	 */
	public class EPage extends Box implements IPage
	{
		private var _isEditable:Boolean;
		
		private var childList:Vector.<IEComponent> = null;
		
		private var _currentHitTarget:Object = null;
		
		private var lastEelement:Object = null;
		
		private var _scene:Object = null;
		
		public var aniList:Array = [];
		
		private var playIndex:int = 0;
		
		private var image_bg:Image = null;
		
		public function EPage() 
		{
			childList = new Vector.<IEComponent>();
		}
		
		override protected function preinitialize():void 
		{
			mouseChildren = false;
			this.width = PageConfig.PAGE_WIDTH;
			this.height = PageConfig.PAGE_HEIGHT;
		}
		
		override protected function initialize():void
		{
			mouseChildren = true;
			mouseEnabled = true;
			this.scene = 0xffffff
			this.isEditable = true;
		}
		
		override public function dispose():void
		{
			for (var i:int = 0, n:int = this.numChildren; i < n; i++)
			{
				var target:DisplayObject = this.getChildAt(i) as DisplayObject
				if (target&&target is EComponent)
				{
					EComponent(target).dispose();
				}
			}
			aniList && (aniList.length = 0);
			aniList = null;
			childList && (childList.length = 0);
			childList = null;
			_currentHitTarget = null;
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onDownEvent);
		}
		
		protected function onDownEvent(e:MouseEvent):void 
		{
			var len:int = childList.length;
			for (var i:int = 0; i < len; i++)
			{
				var p:Point = new Point(DisplayObject(childList[i]).mouseX, DisplayObject(childList[i]).mouseY);
				if (inBounds(p,DisplayObject(childList[i]).getBounds(DisplayObject(childList[i])))&&(e.target.parent==this||e.target.parent==childList[i]||e.target.parent is EGrid))
				{
					childList[i].isSelected = true;
					_currentHitTarget = childList[i];
					sendEvent(UIEvent.SELECT_ITEM,{target:_currentHitTarget});
				}
				else
				{
					childList[i].isSelected = false;
				}
			}
		}
		
		protected function onMoveEvent(e:UIEvent):void 
		{
			sendEvent(UIEvent.MOVE, e.data);
		}
		
		protected function onLinkEvent(e:UIEvent):void
		{
			sendEvent(UIEvent.LINK, e.data);
		}
		
		/**添加显示对象*/
		override public function addElement(element:DisplayObject, x:Number, y:Number):void {
			element.x =x
			element.y =y
			addChild(element);
			element.addEventListener(UIEvent.MOVE, onMoveEvent, false, 0, true);
			element.addEventListener(UIEvent.LINK, onLinkEvent, false, 0, true);
			childList.push(element);
		}
		
		/**删除子显示对象，子对象为空或者不包含子对象时不抛出异常*/
		override public function removeElement(element:DisplayObject):void {
			if (element && contains(element))
			{
				removeChild(element);
				childList.splice(childList.indexOf(element), 1);
			}
		}
		
		override protected function changeSize():void
		{
			super.changeSize();
			super.resetPosition();
		}
		
		/**
		 * 是否包含关系
		 * @param	r1  子对象
		 * @param	r2  父对象
		 * @return
		 */
		public function inBounds(p1:Point,r2:Rectangle):Boolean
		{
			if (p1 == null || r2 == null)
			{
				return false;
			}
			return (p1.x > r2.x) && (p1.x < r2.x+r2.width) && (p1.y > r2.y) && (p1.y < r2.y + r2.height);
		}
		
		 /** 
         * AS3冒泡排序算法 
         * @param arr 需要排序的数组 
         * @param isAsc 是否升序 
         * @return 返回排序后的数组 
         */  
        public function sort(arr:Vector.<IEComponent>, isAsc:Boolean = true):Vector.<IEComponent>  
        {  
            if(arr == null)  
            {  
                throw new Error("Array is null.");  
            }  
            var tmp:*;  
            if(isAsc)  
            {  
                for(var i:int = 0; i < arr.length; i++)  
                {  
                    for(var j:int = arr.length - 1; j > i; j--)  
                    {  
                        if(int(arr[j].exml.@layer) < int(arr[j - 1].exml.@layer))  
                        {  
                            tmp = arr[j];  
                            arr[j] = arr[j - 1];  
                            arr[j - 1] = tmp;  
                        }  
                    }  
                }  
            }  
            else  
            {  
                for(i = 0; i < arr.length; i++)  
                {  
                    for(j = arr.length - 1; j > i; j--)  
                    {  
                        if(int(arr[j].exml.@layer) > int(arr[j - 1].exml.@layer))
                        {  
                            tmp = arr[j];  
                            arr[j] = arr[j - 1];  
                            arr[j - 1] = tmp;  
                        }  
                    }  
                }  
            }  
            return arr;  
        }  
		
		public function get currentHitTarget():Object
		{
			return _currentHitTarget;
		}
		
		public function get isEditable():Boolean 
		{
			return _isEditable;
		}
		
		public function set isEditable(value:Boolean):void 
		{
			if (_isEditable != value)
			{
				_isEditable = value;
				if (value)
				{
					addEventListener(MouseEvent.MOUSE_DOWN, onDownEvent);
				}
				else
				{
					removeEventListener(MouseEvent.MOUSE_DOWN, onDownEvent);
				}
			}
		}
		
		public function get exml():XML{
			var len:int = childList.length;
			sort(childList);
			var rootNode:XML=<View width={PageConfig.PAGE_WIDTH} height={PageConfig.PAGE_HEIGHT}/>
			var xml:XML=<EPage width={PageConfig.PAGE_WIDTH} height={PageConfig.PAGE_HEIGHT}  isEditable={isEditable} scaleX="1" scaleY="1" scene={scene}></EPage>
			for (var i:int = 0; i < len; i++)
			{
				xml.appendChild(childList[i].exml);
			}
			rootNode.appendChild(xml);
			return rootNode;
		}
		
		public function get scene():Object {
			return _scene;
		}
		
		public function set scene(value:Object):void 
		{
			_scene = value;
			image_bg && image_bg.remove();
			graphics.clear();
			if (!isNaN(Number(_scene))&&_scene!=null)
			{
				graphics.beginFill(Number(_scene));
				graphics.drawRect(0, 0, this.width, this.height);
				graphics.endFill();
			}
			else if (_scene is String)
			{
				image_bg = image_bg || new Image();
				image_bg.url = String(_scene);
				image_bg.addEventListener(UIEvent.IMAGE_LOADED, onLoaded);
				addChildAt(image_bg, 0);
			}
			else
			{
				graphics.beginFill(0xffffff);
				graphics.drawRect(0, 0, this.width, this.height);
				graphics.endFill();
			}
		}
		
		private function onLoaded(e:UIEvent):void 
		{
			image_bg.x = (PageConfig.PAGE_WIDTH - image_bg.width) * 0.5;
			image_bg.y = (PageConfig.PAGE_HEIGHT - image_bg.height) * 0.5;
		}
		
		public function playNext():Boolean
		{
			if (aniList){
				if (playIndex < this.aniList.length)	{
					//播放
					aniList[playIndex].start();
					if (playIndex <= aniList.length - 1){
						playIndex++;
					}
					return true;
				}
				return false;
			}
			return false;
		}
		
		public function playPre():Boolean{
			if (aniList){
				if (playIndex >=0){
					if ((playIndex<=aniList.length||playIndex>0)&&playIndex>0){
						playIndex--;
						aniList[playIndex].stop();
						aniList[playIndex].alpha = 0;
						return true;
					}
					return false;
				}
				return false
			}
			return false
		}
	}
}