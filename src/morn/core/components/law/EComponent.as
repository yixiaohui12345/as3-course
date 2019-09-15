package morn.core.components.law
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.events.ContextMenuEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import frameworks.message.OperateType;
	import morn.core.components.Button;
	import morn.core.components.Component;
	import morn.core.components.View;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.editor.core.IEComponent;
	import mouse.MouseType;
	
	[UIEvent(name = "moveDelay", type = "morn.core.events.UIEvent")]
	
	[UIEvent(name = "propertyChange", type = "morn.core.events.UIEvent")]
	
	[UIEvent(name = "link", type = "morn.core.events.UIEvent")]
	
	/**
	 * ...
	 * @author yxh
	 */
	public class EComponent extends Component implements IEComponent
	{
		protected static const MENUS:Array = ["[复制]", "[删除]", "[上置一层]", "[下置一层]","[置顶]","[置底]"];
		
		/**组件基类
		 * 组件的生命周期：preinitialize > createChildren > initialize > 组件构造函数*/
		protected var _type:int = 0;
		
		protected var _id:String = null;
		
		protected var _isSelected:Boolean = false;
		
		protected var _eGrid:EGrid = null;
		
		protected var _buttonDelete:Button = null;
		
		protected var _animation:String = null;
		
		protected var _menusItems:Array = [];
		
		protected var _menuHandler:Handler = null;
		
		protected var _isPreview:Boolean = false;
		
		protected var _state:State = null;
		
		protected var _starter:Object = null;
		
		protected var _link:String = null;
		
		public function EComponent()
		{
		
		}
		
		override protected function preinitialize():void
		{
			mouseEnabled = mouseChildren = false;
		}
		
		override protected function createChildren():void
		{
			addChild(_eGrid = new EGrid());
		}
		
		override protected function initialize():void
		{
			mouseEnabled = mouseChildren = true;
			_state = new State();
			_buttonDelete.name = "itemDelete"
			_buttonDelete.addEventListener(MouseEvent.CLICK, deleteEvent);
			addEventListener(MouseEvent.MOUSE_MOVE, onMoveEvent);
			addEventListener(MouseEvent.MOUSE_OUT, onOutEvent);
			initStarter();
		}
		
		override public function dispose():void
		{
			super.dispose();
			if (App.stage.hasEventListener(KeyboardEvent.KEY_DOWN))
			{
				App.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
			}
			removeEventListener(MouseEvent.MOUSE_MOVE, onMoveEvent);
			removeEventListener(MouseEvent.MOUSE_OUT, onOutEvent);
			removeEventListener(MouseEvent.MOUSE_DOWN, onDownEvent);
			
			_buttonDelete && _buttonDelete.dispose();
			_buttonDelete && _buttonDelete.removeEventListener(MouseEvent.CLICK, deleteEvent);
			_buttonDelete = null;
			
			_eGrid && _eGrid.dispose();
			_eGrid = null;
			
			for (var i:int = 0, n:int = _menusItems.length; i < n; i++)
			{
				if (_menusItems[i])
				{
					_menusItems[i].removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMenuEvent);
					_menusItems[i] = null;
				}
			}
			_starter = null;
			_menus = null;
			_menusItems = null;
		}
		
		private function deleteEvent(e:MouseEvent):void 
		{
			sendEvent(UIEvent.DELETE, {target:this});
		}
		
		private function keyDownEvent(e:KeyboardEvent):void
		{
			if (!_state.isLast){
				_state.isLast = true;
				_state.pre_x = this.x;
				_state.pre_y = this.y;
			}
			switch(e.keyCode)
			{
				case Keyboard.DELETE:
					sendEvent(UIEvent.DELETE, {target:this});
					break;
				case Keyboard.LEFT:
					this.x -= 1;
					break;
				case Keyboard.RIGHT:
					this.x += 1;
					break;
				case Keyboard.UP:
					this.y -= 1;
					break;
				case Keyboard.DOWN:
					this.y+=1
					break;
			}
			App.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpEvent, false, 0, true);
		}
		
		private function keyUpEvent(e:KeyboardEvent):void 
		{
			App.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpEvent);
			_state.isLast = false;
			var dx:Number = _state.pre_x - this.x;
			var dy:Number = _state.pre_y - this.y;
			if (dx != 0){
				this.parent&&(this.parent is EPage)&&(this.parent as EPage).sendEvent(UIEvent.MOVE_DELAY, [{key: "x", target: this, oldValue: _state.pre_x, newValue:this.x}]);
			}
			if (dy != 0){
				this.parent&&(this.parent is EPage)&&(this.parent as EPage).sendEvent(UIEvent.MOVE_DELAY, [{key: "y", target: this, oldValue:_state.pre_y, newValue:this.y}]);
			}
		}
		
		public function backStarter():void
		{
			for (var p:String in _starter)
			{
				if (_starter[p] != null)
				{
					this[p] = _starter[p];
				}
			}
		}
		
		protected function initStarter():void
		{
			_starter = {};
			_starter.x = x;
			_starter.y = y;
			_starter.scale = 1;
			_starter.scaleX = 1;
			_starter.scaleY = 1;
			_starter.rotation = rotation;
			_starter.rotationX = rotationX;
			_starter.rotationY = rotationY;
			_starter.rotationZ = rotationZ;
			_starter.animation = "null";
		}
		
		protected function startMove():void
		{
			if (!isPreview && _state.mouse_state == 9)
			{
				_state.pre_x = this.x;
				_state.pre_y = this.y;
				startDrag(false);
			}
		}
		
		protected function onDownEvent(e:MouseEvent):void
		{
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onUpEvent);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMoveEvent);
			
			_state.mouse_dx = this.parent.mouseX;
			_state.mouse_dy = this.parent.mouseY;
			_state.isMoving = true;
			startMove();
		}
		
		protected function onMoveEvent(e:MouseEvent):void
		{
			if (isPreview || _state.isMoving)
			{
				return
			}
			if (!isSelected)
			{
				Mouse.cursor = MouseCursor.ARROW
				return
			}
			if (e.target.name && String(e.target.name).indexOf("item") != -1)
			{
				var id:int = int(String(e.target.name).substr(4));
				_state.mouse_state = id;
				var quadrant:int = getQuadrant();
				switch (id)
				{
				case 1: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_LEFT
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_RIGHT
					}
					break;
				case 2: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_VERTICAL;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_HORIZON;
					}
					break;
				case 3: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_RIGHT;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_LEFT
					}
					break;
				case 4: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_HORIZON;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_VERTICAL;
					}
					break;
				case 5: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_HORIZON;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_VERTICAL;
					}
					break;
				case 6: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_RIGHT;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_LEFT
					}
					break;
				case 7: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_VERTICAL;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_HORIZON;
					}
					break;
				case 8: 
					if (quadrant == 1 || quadrant == 3)
					{
						Mouse.cursor = MouseType.MOUSE_LEFT;
					}
					else
					{
						Mouse.cursor = MouseType.MOUSE_RIGHT;
					}
					break;
				}
			}
			else
			{
				if (this.type == EType.TEXT && doubleClickEnabled && (mouseX > 16 && mouseX < this.width - 16 && mouseY > 16 && mouseY < this.height - 16))
				{
					Mouse.cursor = MouseCursor.IBEAM
					_state.mouse_state = 10;
				}
				else
				{
					Mouse.cursor = MouseType.MOUSE_MOVING;
					_state.mouse_state = 9;
				}
			}
		}
		
		protected function onOutEvent(e:MouseEvent):void
		{
			if (isPreview || _state.isMoving)
			{
				return
			}
			if (!isSelected)
			{
				Mouse.cursor = MouseCursor.ARROW
				return
			}
			Mouse.cursor = MouseCursor.ARROW;
			_state.mouse_state = 10;
		}
		
		protected function onUpEvent(e:MouseEvent):void
		{
			this.stopDrag();
			_state.isMoving = false;
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onUpEvent);
			
			var deltaX:Number = this.parent.mouseX - _state.mouse_dx;
			var deltaY:Number = this.parent.mouseY - _state.mouse_dy;
			if (deltaX>=0 || deltaY >= 0)
			{
				this.parent&&(this.parent is EPage)&&(this.parent as EPage).sendEvent(UIEvent.MOVE_DELAY, [{key: "x", target: this, oldValue: _state.pre_x, newValue: x}, {key: "y", target: this, oldValue: _state.pre_y, newValue: y}]);
			}
			
			var quadrant:int = getQuadrant();
			switch (_state.mouse_state)
			{
			case 1: 
				this.x = this.x + deltaX;
				this.y = this.y + deltaY
				if (quadrant == 1)
				{
					_state.now_w = this.width - deltaX
					_state.now_h = this.height - deltaY
				}
				else if (quadrant == 2)
				{
					_state.now_w = this.width - deltaY;
					_state.now_h = this.height + deltaX
				}
				else if (quadrant == 3)
				{
					_state.now_w = this.width + deltaX
					_state.now_h = this.height + deltaY;
				}
				else
				{
					_state.now_w = this.width + deltaY
					_state.now_h = this.height - deltaX
				}
			case 2: 
				if (quadrant == 1)
				{
					this.y += deltaY;
					_state.now_h = this.height - deltaY;
				}
				else if (quadrant == 2)
				{
					this.x += deltaX;
					_state.now_h = this.height + deltaX
				}
				else if (quadrant == 3)
				{
					this.y += deltaY;
					_state.now_h = this.height + deltaY
				}
				else
				{
					this.x += deltaX;
					_state.now_h = this.height - deltaX
				}
				break;
			case 3: 
				if (quadrant == 1)
				{
					this.y += deltaY;
					_state.now_w = this.width + deltaX
					_state.now_h = this.height - deltaY
				}
				else if (quadrant == 2)
				{
					this.x += deltaX;
					_state.now_w = this.width + deltaY
					_state.now_h = this.height + deltaX
				}
				else if (quadrant == 3)
				{
					this.y += deltaY;
					_state.now_w = this.width - deltaX
					_state.now_h = this.height + deltaY
				}
				else
				{
					this.x += deltaX;
					_state.now_w = this.width - deltaY;
					_state.now_h = this.height - deltaX
				}
				break;
			case 4: 
				if (quadrant == 1)
				{
					this.x += deltaX;
					_state.now_w = this.width - deltaX
				}
				else if (quadrant == 2)
				{
					this.y += deltaY
					_state.now_w = this.width - deltaY
				}
				else if (quadrant == 3)
				{
					this.x += deltaX;
					_state.now_w = this.width + deltaX
				}
				else
				{
					this.y += deltaY;
					_state.now_w = this.width + deltaY
				}
				break;
			case 5: 
				if (quadrant == 1)
				{
					_state.now_w = this.width + deltaX
				}
				else if (quadrant == 2)
				{
					_state.now_w = this.width + deltaY
				}
				else if (quadrant == 3)
				{
					_state.now_w = this.width - deltaX
				}
				else
				{
					_state.now_w = this.width - deltaY
				}
				break;
			case 6: 
				if (quadrant == 1)
				{
					this.x += deltaX;
					_state.now_w = this.width - deltaX
					_state.now_h = this.height + deltaY
				}
				else if (quadrant == 2)
				{
					this.y += deltaY;
					_state.now_w = this.width - deltaY
					_state.now_h = this.height - deltaX
				}
				else if (quadrant == 3)
				{
					this.x += deltaX;
					_state.now_w = this.width + deltaX
					_state.now_h = this.height - deltaY
				}
				else
				{
					this.y += deltaY;
					_state.now_w = this.width + deltaY
					_state.now_h = this.height + deltaX
				}
				break;
			case 7: 
				if (quadrant == 1)
				{
					_state.now_h = this.height + deltaY
				}
				else if (quadrant == 2)
				{
					_state.now_h = this.height - deltaX
				}
				else if (quadrant == 3)
				{
					_state.now_h = this.height - deltaY
				}
				else
				{
					_state.now_h = this.height + deltaX
				}
				break;
			case 8: 
				if (quadrant == 1)
				{
					_state.now_w = this.width + deltaX
					_state.now_h = this.height + deltaY
				}
				else if (quadrant == 2)
				{
					_state.now_w = this.width + deltaY
					_state.now_h = this.height - deltaX
				}
				else if (quadrant == 3)
				{
					_state.now_w = this.width - deltaX
					_state.now_h = this.height - deltaY
				}
				else
				{
					_state.now_w = this.width - deltaY
					_state.now_h = this.height + deltaX
				}
				break;
			}
			
			!isNaN(_state.now_w) ? this.width = _state.now_w : null;
			!isNaN(_state.now_h) ? this.height = _state.now_h : null;
			_state.mouse_state = 9
			addEventListener(MouseEvent.MOUSE_MOVE, onMoveEvent);
		}
		
		private function onMenuEvent(e:ContextMenuEvent):void
		{
			if (_menus == null || _menus.length == 0){
				return;
			}
			switch(_menus.indexOf(e.currentTarget.caption)){
				case 0:
					menuHandler && menuHandler.executeWith([{action:OperateType.COPY,child:this}]);
					break;
				case 1:
					menuHandler && menuHandler.executeWith([{action:OperateType.DELETE,child:this}]);
					break;
				case 2:
					menuHandler && menuHandler.executeWith([{action:OperateType.UPPER,child:this}]);
					break;
				case 3:
					menuHandler && menuHandler.executeWith([{action:OperateType.DOWNER,child:this}]);
					break;
				case 4:
					menuHandler && menuHandler.executeWith([{action:OperateType.UPPEST,child:this}]);
					break;
				case 5:
					menuHandler && menuHandler.executeWith([{action:OperateType.DOWNEST,child:this}]);
					break;
			}
			
		}
		
		protected function changeEditState():void
		{
			if (_eGrid)
			{
				_eGrid.editState = _isSelected;
				_buttonDelete.visible = isPreview ? false : _isSelected;
			}
		}
		
		/**拉伸框**/
		public function get eGrid():EGrid
		{
			return _eGrid;
		}
		
		public function set eGrid(value:EGrid):void
		{
			_eGrid = value;
		}
		
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if (_isSelected != value)
			{
				_isSelected = value;
				if (value)
				{
					App.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent, false, 0, true);
				}
				else
				{
					App.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
				}
				callLater(changeEditState);
			}
		}
		
		public function get attribute():Object
		{
			return null;
		}
		
		public function get exml():XML
		{
			return null;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		private var _menus:Array = null;
		public function get menus():Array
		{
			return _menus;
		}
		public function set menus(value:Array):void
		{
			if (value)
			{
				_menus = value;
				var menu:ContextMenu = new ContextMenu();
				menu.hideBuiltInItems();
				for (var i:int = 0, n:int = value.length; i < n; i++)
				{
					var version:ContextMenuItem = new ContextMenuItem(value[i]);
					version.separatorBefore = true;
					menu.customItems.push(version);
					version.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onMenuEvent)
					_menusItems[i] = version
				}
				this.contextMenu = menu;
			}
			else{
				this.contextMenu = null;
			}
		}
		
		public function get menuHandler():Handler
		{
			return _menuHandler;
		}
		
		public function set menuHandler(value:Handler):void
		{
			_menuHandler = value;
		}
		
		public function get isPreview():Boolean
		{
			return _isPreview;
		}
		
		public function set isPreview(value:Boolean):void
		{
			_isPreview = value;
			if (!value)
			{
				addEventListener(MouseEvent.MOUSE_DOWN, onDownEvent);
				
				if (_eGrid)
					_eGrid.visible = true;
				_buttonDelete.visible = true;
				this.menus = MENUS;
			}
			else
			{
				App.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownEvent);
				removeEventListener(MouseEvent.MOUSE_DOWN, onDownEvent);
				if (_eGrid)
					_eGrid.visible = false;
				_buttonDelete.visible = false;
			}
		}
		
		public function get animation():String
		{
			return _animation;
		}
		
		public function set animation(value:String):void
		{
			if (_animation != value)
			{
				_animation = value;
				if (!this.isPreview)
					start(value);
				else
					alpha = 0;
			}
		}
		
		public function get starter():Object
		{
			return _starter;
		}
		
		public function start(ani:String = null):void
		{
			try
			{
				ani = (ani == null) ? _animation : ani;
				var json:Object = JSON.parse(ani);
				alpha = 1;
				if (json)
				{
					TweenLite.from(this, json.duration, json.vars);
				}
			}
			catch (evt:Error)
			{
			}
		}
		
		public function stop():void
		{
			TweenLite.killTweensOf(this);
		}
		
		protected function onLinkHandler(e:MouseEvent):void
		{
			if (_link)
			{
				try
				{
					var json:Object = JSON.parse(_link);
					switch(json.type)
					{
						case "Net":
							navigateToURL(new URLRequest(json.url));
							break;
						case "Page":
							sendEvent(UIEvent.LINK, json);
							break;
					}
				}
				catch (evt:Error){}
			}
		}
		
		protected function getQuadrant():int
		{
			var _quadrant:int
			if (this.rotation > 0)
				if (rotation == 90)
					_quadrant = 2
				else
					_quadrant = int(this.rotation / 90) + 1;
			else if (rotation == -90)
				_quadrant == 3
			else
				_quadrant = int(this.rotation / -90) + 1;
			return _quadrant;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		/**
		 * 超链接
		 */
		public function get link():String 
		{
			return _link;
		}
		
		public function set link(value:String):void 
		{
			if (_link != value)
			{
				_link = value;
				if (isPreview&&_link)
				{
					addEventListener(MouseEvent.CLICK, onLinkHandler);
				}
			}
		}
	}
}

class State
{
	public var pre_x:Number = Number.NaN;
	
	public var pre_y:Number = Number.NaN;
	
	public var now_w:Number = Number.NaN;
	
	public var now_h:Number = Number.NaN;
	
	public var mouse_dx:Number = Number.NaN;
	
	public var mouse_dy:Number = Number.NaN;
	
	public var mouse_state:Number = Number.NaN;
	
	public var isMoving:Boolean = false;
	
	public var isLast:Boolean = false;
}