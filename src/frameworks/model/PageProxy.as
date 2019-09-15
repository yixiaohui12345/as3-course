package frameworks.model
{
	import com.usunekoserv.XML2Array;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.xml.XMLDocument;
	import frameworks.message.DataMsg;
	import frameworks.message.OperateType;
	import frameworks.model.command.CommandManager;
	import frameworks.model.command.EditCommand;
	import frameworks.model.vo.PageVO;
	import frameworks.model.vo.PreviewVO;
	import frameworks.view.widget.Alert;
	import morn.core.components.law.EComponent;
	import morn.core.components.law.EImage;
	import morn.core.components.law.EMovie;
	import morn.core.components.law.EMusic;
	import morn.core.components.law.EPage;
	import morn.core.components.law.ESvg;
	import morn.core.components.law.EText;
	import morn.core.components.law.EType;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import mvcexpress.mvc.Proxy;
	import mx.collections.ArrayCollection;
	import org.utils.DrawHelper;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class PageProxy extends Proxy
	{
		public var vector:Vector.<PageVO> = null;
		
		private var _scale:Number = Number.NaN;
		
		public var currentPageIndex:int = 0;
		
		public var previewVector:Vector.<EPage>
		
		public function PageProxy()
		{
			vector = new Vector.<PageVO>();
		}
		
		/**
		 * 更新幻灯片列表缩略图
		 */
		private function updateSlide():void
		{
			var bitmapArr:Array = [];
			for (var i:int = 0, len:int = vector.length; i < len; i++)
			{
				if (vector[i].page)
				{
					bitmapArr.push(DrawHelper.createThumbnail(vector[i].page, new Rectangle(0, 0, 1280, 720), true));
				}
			}
			sendMessage(DataMsg.RESPONSE_UPDATE_SLIDE,bitmapArr);
		}
		
		public function preview():void
		{
			previewVector = previewVector || new Vector.<EPage>();
			previewVector && previewVector.splice(0, previewVector.length);
			for (var i:int = 0, len:int = vector.length; i < len; i++)
			{
				var page:EPage = new EPage();
				page.width = PageConfig.PAGE_WIDTH;
				page.height = PageConfig.PAGE_HEIGHT;
				page.scene = vector[i].page.exml.EPage.@scene.toXMLString()
				page.isEditable = false;
				previewVector.push(page);
				for (var j:int = 0, childLen:int = vector[i].page.exml.EPage.children().length(); j < childLen; j++)
				{
					var clsName:String = vector[i].page.exml.EPage.children()[j].name();
					var xml:XML = vector[i].page.exml.EPage.children()[j];
					var item:EComponent = null;
					switch (clsName)
					{
					case "EText": 
						item = new EText();
						break;
					case "EImage": 
						item = new EImage();
						break;
					case "EMovie": 
						item = new EMovie();
						break;
					case "EMusic":
						item = new EMusic();
						break;
					case "ESvg":
						item = new ESvg();
						break;
					}
					
					var list2:XMLList = xml.attributes();
					for each (var attrs:XML in list2)
					{
						var prop:String = attrs.name().toString();
						var value:String = attrs.toString();
						if (item.hasOwnProperty(prop))
						{
							if (prop == "animation" && value != null){
								page.aniList.push(item);
							}
							item[prop] = (value == "true" ? true : (value == "false" ? false : value))
						}
					}
					item.isPreview = true;
					item.isSelected=false
					page.addElement(item, item["x"], item["y"]);
				}
			}
			sendMessage(DataMsg.RESPONSE_PREVIEW, previewVector);
		}
		
		private function changeEvent(e:UIEvent):void
		{
			CommandManager.inst.Edit(e.data.key, e.data.target, e.data.oldValue, e.data.newValue);
		}
		
		private function deleteEvent(e:UIEvent):void
		{
			if (e.data&&e.data.target)
			{
				var target:EComponent=e.data.target as EComponent
				if (target.parent&&target.parent.visible==true&&target.isSelected)
				{
					(target.parent as EPage).removeElement(target);
					CommandManager.inst.Delete(vector[currentPageIndex].page, e.data.target);
					updateSlide()
				}
			}
		}
		
		private function selectEvent(e:UIEvent):void 
		{
			sendMessage(DataMsg.SELECT_ITEM, e.data.target);
		}
		
		private function moveEvent(e:UIEvent):void
		{
			var list:Array = e.data;
			if (list == null || list.length == 0)
			{
				return
			}
			var array:ArrayCollection = new ArrayCollection();
			for (var i:int = 0, len:int = list.length; i < len; i++)
			{
				array.addItem(new EditCommand(list[i].key, list[i].target, list[i].oldValue, list[i].newValue))
			}
			CommandManager.inst.Multi(array);
			updateSlide()
		}
		
		private function removeEvent(e:Event):void 
		{
			if (currentPageIndex > 0)
			{
				if (currentPageIndex < vector.length)
				{
					vector.removeAt(currentPageIndex);
				}
				currentPageIndex--;
				showPage({index:currentPageIndex})
				updateSlide();
			}
		}
		
		public function scalePage(data:Object):void
		{
			if (vector && vector[currentPageIndex])
			{
				this.scale = Number(data);
			}
		}
		
		public function addImage(data:Object):void
		{
			if (vector == null || vector[currentPageIndex] == null)
			{
				return 
			}
			var temp:PageVO = vector[currentPageIndex];
			var item:EImage = new EImage(data.url);
			item.isPreview = false;
			item.menuHandler = new Handler(menuHandler);
			item.addEventListener(UIEvent.DELETE, deleteEvent);
			var px:Number = Math.random() * 100;
			var py:Number = Math.random() * 100
			temp.page.addElement(item, px, py);
			CommandManager.inst.Add(temp.page, item);
			sendMessage(DataMsg.RESPONSE_ADD_ITEM, {item:item,px:px, py:py});
			updateSlide()
		}
		
		public function addText(data:Object):void
		{
			if (vector == null || vector[currentPageIndex] == null)
			{
				return 
			}
			var temp:PageVO = vector[currentPageIndex];
			var item:EText = new EText("请编辑内容");
			item.addEventListener(UIEvent.DELETE, deleteEvent);
			item.addEventListener(UIEvent.PROPERTY_CHANGE, changeEvent);
			item.isPreview = false;
			item.menuHandler = new Handler(menuHandler);
			temp.page.addElement(item, data.x, data.y);
			CommandManager.inst.Add(temp.page, item);
			sendMessage(DataMsg.RESPONSE_ADD_ITEM, {item:item,px:data.x, py:data.y});
			updateSlide()
		}
		
		public function addMovie(data:Object):void
		{
			if (vector == null || vector[currentPageIndex] == null)
			{
				return 
			}
			var temp:PageVO = vector[currentPageIndex];
			var item:EMovie = new EMovie();
			item.url = data.url;
			item.menuHandler = new Handler(menuHandler);
			item.isPreview = false;
			item.addEventListener(UIEvent.DELETE, deleteEvent);
			temp.page.addElement(item, 0, 0);
			CommandManager.inst.Add(temp.page, item);
			sendMessage(DataMsg.RESPONSE_ADD_ITEM, {item:item,px:data.x, py:data.y});
			updateSlide()
		}
		
		public function addMusic(data:Object):void
		{
			if (vector == null || vector[currentPageIndex] == null)
			{
				return 
			}
			var temp:PageVO = vector[currentPageIndex];
			var item:EMusic = new EMusic();
			item.skin = "png.style.icon.music";
			item.url = data.url;
			item.menuHandler = new Handler(menuHandler);
			item.isPreview = false;
			item.addEventListener(UIEvent.DELETE, deleteEvent);
			temp.page.addElement(item, 10, 10);
			CommandManager.inst.Add(temp.page, item);
			sendMessage(DataMsg.RESPONSE_ADD_ITEM, {item:item,px:10, py:10});
			updateSlide()
		}
		
		public function addSvg(data:Object):void
		{
			if (vector == null || vector[currentPageIndex] == null)
			{
				return 
			}
			var temp:PageVO = vector[currentPageIndex];
			var item:ESvg = new ESvg();
			item.url = data.url;
			item.isPreview = false;
			item.menuHandler = new Handler(menuHandler);
			item.addEventListener(UIEvent.DELETE, deleteEvent);
			temp.page.addElement(item, 10, 10);
			CommandManager.inst.Add(temp.page, item);
			sendMessage(DataMsg.RESPONSE_ADD_ITEM, {item:item,px:10, py:10});
			updateSlide()
		}
		
		public function addAni(data:Object):void
		{
		
		}
		
		public function operate(data:Object):void
		{
			if (!vector || !vector[currentPageIndex] || !vector[currentPageIndex].page || !vector[currentPageIndex].page.currentHitTarget || !(vector[currentPageIndex].page.currentHitTarget is EComponent))
			{
				return
			}
			var index:int = 0;
			var comp:EComponent = data.child ? (data.child as EComponent) : (vector[currentPageIndex].page.currentHitTarget as EComponent)
			var container:EPage = vector[currentPageIndex].page;
			switch (data.action)
			{
			case OperateType.COPY: 
				var attribute:Object = comp.attribute
				if (attribute == null)
				{
					Alert.inst.show("该组件不支持复制");
					return 
				}
				var cls:Class = getDefinitionByName(attribute.className) as Class;
				var item:* = new cls();
				for (var key:String in attribute)
				{
					if (key != "className")
					{
						item[key] = attribute[key];
					}
				}
				item.menuHandler = new Handler(menuHandler)
				item.isPreview = false
				item.addEventListener(UIEvent.DELETE, deleteEvent);
				item.addEventListener(UIEvent.PROPERTY_CHANGE, changeEvent);
				CommandManager.inst.Add(container, comp);
				container.addElement(item, 10, 10);
				break;
			case OperateType.RESTORE: 
				comp.backStarter();
				break;
			case OperateType.UPPER: 
				index = container.getChildIndex(comp);
				if (index < container.numChildren - 1)
				{
					container.setChildIndex(comp, index + 1);
				}
				break;
			case OperateType.UPPEST: 
				container.setChildIndex(comp, container.numChildren - 1);
				break;
			case OperateType.DOWNER: 
				index = container.getChildIndex(comp);
				if (index > 0)
				{
					container.setChildIndex(comp, index - 1);
				}
				break;
			case OperateType.DOWNEST: 
				container.setChildIndex(comp, 0);
				break;
			case OperateType.DELETE: 
				container.removeElement(comp);
				CommandManager.inst.Delete(container, comp);
				break;
			}
			updateSlide()
		}
		
		public function play(data:Object):void
		{
			if (currentHitTarget&&currentHitTarget.hasOwnProperty(data.key))
			{
				(currentHitTarget as EComponent).start(data.value);
			}
		}
		
		public function modify(data:Object):void
		{
			if (vector && vector[currentPageIndex] && vector[currentPageIndex].page && vector[currentPageIndex].page.currentHitTarget && vector[currentPageIndex].page.currentHitTarget.isSelected && vector[currentPageIndex].page.currentHitTarget.hasOwnProperty(data.key))
			{
				if (data.value == null&&(data.key=="bold"||data.key=="underline"||data.key=="italic"))
				{
					CommandManager.inst.Edit(data.key, vector[currentPageIndex].page.currentHitTarget, vector[currentPageIndex].page.currentHitTarget[data.key], !vector[currentPageIndex].page.currentHitTarget[data.key]);
				}
				else if (vector[currentPageIndex].page.currentHitTarget[data.key] != data.value)
				{
					CommandManager.inst.Edit(data.key, vector[currentPageIndex].page.currentHitTarget, vector[currentPageIndex].page.currentHitTarget[data.key], data.value);
				}
				updateSlide()
			}
		}
		
		public function modifyPage(data:Object):void
		{
			if (vector && vector[currentPageIndex] && vector[currentPageIndex].page)
			{
				vector[currentPageIndex].page[data.key] = data.value;
			}
		}
		
		public function addPage(data:Object):void
		{
			if (vector)
			{
				var i:int = 0;
				var len:int = vector.length;
				for (i = 0; i < len; i++)
				{
					if (vector[i] && vector[i].page)
					{
						vector[i].page.visible = false;
					}
				}
				var value:Number = (App.stage.stageHeight - 120) * 0.9;
				value = value > PageConfig.PAGE_HEIGHT ? 1 : Number(Number(value / PageConfig.PAGE_HEIGHT).toFixed(1));
				var vo:PageVO = new PageVO();
				var page:EPage = new EPage();
				page.scene = 0xffffff;
				//page.addEventListener(Event.REMOVED, removeEvent);
				vo.page = page;
				currentPageIndex = vo.index = vector.length;
				vector.push(vo);
				this.scale = value;
				var xml:XML = data.model?XML(data.model):PPTModel.MODE1;
				len= xml.children().length()
				for (i = 0; i < len; i++)
				{
					var clsName:String = xml.children()[i].name();
					var child:XML = xml.children()[i]
					var item:EComponent = null;
					switch (clsName)
					{
					case "EText": 
						item = new EText();
						break;
					case "EImage": 
						item = new EImage();
						break;
					case "EMovie": 
						item = new EMovie();
						break;
					case "EMusic":
						item = new EMusic();
						break;
					case "ESvg":
						item = new ESvg();
						break;
					}
					item.menuHandler = new Handler(menuHandler);
					var list2:XMLList = child.attributes();
					for each (var attrs:XML in list2)
					{
						var prop:String = attrs.name().toString();
						var va:String = attrs.toString();
						if (item.hasOwnProperty(prop))
						{
							if (prop == "animation" && va != null)
							{
								page.aniList.push(item);
							}
							item[prop] = (va == "true" ? true : (va == "false" ? false : va))
						}
					}
					item.addEventListener(UIEvent.PROPERTY_CHANGE, changeEvent);
					item.addEventListener(UIEvent.DELETE, deleteEvent);
					page.addElement(item, item["x"], item["y"]);
				}
				page.addEventListener(UIEvent.MOVE_DELAY, moveEvent);
				page.addEventListener(UIEvent.SELECT_ITEM, selectEvent);
				sendMessage(DataMsg.RESPONSE_ADD_PAGE, vo);
				updateSlide();
			}
		}
		
		public function deletePage(data:Object):void
		{
			var index:int = data.index;
			var len:int = vector.length;
			if (vector && index < vector.length)
			{
				var item:PageVO = vector.removeAt(index) as PageVO
				item.page.remove();
				if (item.page.parent)
				{
					CommandManager.inst.Delete(item.page.parent,item.page);
				}
				if (vector.length<=0){
					return 
				}
				if (index == currentPageIndex){
					if (index == len - 1){
						if (index > 0){
							data.target.currentIndex = currentPageIndex = index - 1;	
						}
					}
					else{
						data.target.currentIndex = currentPageIndex = index;
					}
					if (vector[currentPageIndex] && vector[currentPageIndex].page){
							vector[currentPageIndex].page.visible = true;
					}
				}
				else{
						if (currentPageIndex<index){
							data.target.currentIndex = currentPageIndex
						}
						else{
							currentPageIndex--
							data.target.currentIndex=currentPageIndex
						}
						if (vector[currentPageIndex] && vector[currentPageIndex].page){
							vector[currentPageIndex].page.visible = true;
						}
					}
					if (vector && vector.length > 0){
						sendMessage(DataMsg.UPDATE_CURRENT_PAGE, {page:vector[currentPageIndex].page});
					}
			}
		}
		
		public function showPage(data:Object):void
		{
			var index:int = data.index;
			for (var i:int = 0, len:int = vector.length; i < len; i++){
				if (i == index)
				{
					vector[i].page.visible = true;
					currentPageIndex = index;
				}
				else{
					vector[i].page.visible = false;
				}
			}
			if (vector && vector.length > 0){
				sendMessage(DataMsg.UPDATE_CURRENT_PAGE, {page:vector[currentPageIndex].page});
			}
		}
		
		public function remove(index:int):void
		{
			if (vector && index < vector.length){
				var item:PageVO = vector.removeAt(index) as PageVO
			}
		}
		
		private function menuHandler(data:Object):void{
			operate(data);
		}
		
		public function get scale():Number
		{
			return _scale;
		}
		
		public function set scale(value:Number):void
		{
			_scale = value;
			if (vector){
				for (var i:int = 0, len:int = vector.length; i < len; i++){
					if (vector[i] && vector[i].page){
						vector[i].page.scale = value;
						vector[i].page.centerX = 0;
						vector[i].page.centerY =0;
					}
				}
			}
		}
		
		/**
		 * 当前页
		 */
		public function get currentPage():EPage
		{
			if (vector && vector[currentPageIndex]){
				return vector[currentPageIndex].page;
			}
			return null;
		}
		
		/**
		 * 当前选中target
		 */
		public function get currentHitTarget():Object
		{
			if (vector && vector[currentPageIndex] && vector[currentPageIndex].page)
			{
				return vector[currentPageIndex].page.currentHitTarget;
			}
			return null;
		}
		
		public function get pageCount():int
		{
			if (vector)
			{
				return vector.length;
			}
			return 0
		}
		
		public function dispose():void
		{
			if (vector)
			{
				var len:int = vector.length;
				for (var i:int = 0; i < len; i++)
				{
					if (vector[i].page)
					{
						vector[i].page.dispose();
					}
				}
				vector.length = 0;
			}
			currentPageIndex = 0;
		}
	}
}