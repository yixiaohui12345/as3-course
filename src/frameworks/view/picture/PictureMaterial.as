package frameworks.view.picture 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.common.Source;
	import frameworks.events.CompEvent;
	import frameworks.model.vo.MaterialVO;
	import frameworks.model.vo.PictureVO;
	import frameworks.view.widget.Alert;
	import morn.core.components.Box;
	import morn.core.components.FreeTab;
	import morn.core.handlers.Handler;
	import skin.dialog.PictureMaterialUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class PictureMaterial extends PictureMaterialUI
	{
		public static const TYPE:Array = ["J", "R", "Z"]
		
		private var bookType:int = 0;
		
		private var picType:int = 0;
		
		public var tabThumb:FreeTab = null;
		
		public var tabType:FreeTab = null;
		
		public function PictureMaterial() 
		{
			picList.renderHandler = new Handler(renderHandle);
			picList.mouseHandler = new Handler(mouseHandle);
			
			thumbList.renderHandler = new Handler(thumbRender);
			thumbList.mouseHandler = new Handler(thumbMouseHandle);
			
			tabType = new FreeTab(Source.PN_LIST.join(),"png.style.tab.free");
			tabType.x = 5;
			tabType.y = 25;
			tabType.row = 5;
			tabType.labelColors="0xcccccc,0xffffff,0xffffff,0xcccccc";
			tabType.selectedIndex = bookType;
			tabType.space=2
			addChild(tabType);
			
			tabThumb = new FreeTab("背景,人物,场景", "png.style.tab.free");
			tabThumb.x = 5;
			tabThumb.y = 25;
			tabThumb.row = 5;
			tabThumb.space = 2
			tabThumb.labelColors="0xcccccc,0xffffff,0xffffff,0xcccccc";	
			tabThumb.addEventListener(Event.CHANGE, onPicTypeChange);
			tabThumb.visible = thumbList.visible = false;
			tabThumb.selectedIndex = picType;
			addChild(tabThumb);
			
			btn_back.visible = false;
			btn_back.addEventListener(MouseEvent.CLICK, handleBack);
			label_tips.visible = false;
		}
		
		private function onPicTypeChange(e:Event):void 
		{
			if (tabThumb.visible)
			{
				picType=tabThumb.selectedIndex
				dispatchEvent(new CompEvent(CompEvent.SELECT, {requestType:"PictureMaterialProxy",btypeid:picList.dataSource[bookType].bookTypeId, booklib:picList.dataSource[bookType].id, pixel:"2072*1256", picType:TYPE[picType]}))
			}
		}
		
		private function handleBack(e:MouseEvent):void 
		{
			btn_back.visible = false;
			thumbList.visible = false;
			picList.visible = true;
			tabThumb.visible = false;
			tabType.visible = true;
		}
		
		public function resize():void
		{
			this.x = (App.stage.stageWidth - width) * 0.5;
			this.y = (App.stage.stageHeight - height) * 0.5;
			graphics.clear();
			graphics.beginFill(0, 0.4);
			graphics.drawRect(-x, -y, App.stage.stageWidth, App.stage.stageHeight);
			graphics.endFill();
			
		}
		
		public function updateMaterialCover(vo:MaterialVO):void
		{
			if (vo.list && vo.list.length > 0)
			{
				tabType.visible = false;
				thumbList.dataSource = vo.list;
				tabThumb.visible=thumbList.visible=btn_back.visible = true;
				picList.visible = false;
				label_count.text = "总数: " + vo.list.length;
			}
			else
			{
				thumbList.removeAllChild();
				Alert.inst.show("暂无内容");
			}
		}
		
		public function updatePictureCover(vo:PictureVO):void
		{
			if (vo.list && vo.list.length > 0)
			{
				picList.dataSource = vo.list;
				label_count.text = "总数: " + vo.pageCount;
			}
			else
			{
				Alert.inst.show("暂无内容");
			}
		}
		
		private function thumbRender(cell:*, index:int):void
		{
			if (index < thumbList.dataSource.length)
			{
				cell.icon.url = thumbList.dataSource[index].prictureUrl;
				cell.icon.doubleClickEnabled = true;
				cell.icon.addEventListener(MouseEvent.DOUBLE_CLICK, insertPicture);
				cell.toolTip = "双击插入图片";
			}
		}
		
		private function insertPicture(e:MouseEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.LOAD_PIC, e.currentTarget.url));
		}
		
		private function thumbMouseHandle(cell:*, index:int):void
		{
			
		}
		
		private function renderHandle(cell:*, index:int):void
		{
			if (index < picList.dataSource.length)
			{
				cell.icon.url = picList.dataSource[index].coverPath
				cell.label.text = picList.dataSource[index].name;
				cell.toolTip=picList.dataSource[index].name;
			}
		}
		
		private function mouseHandle(event:MouseEvent, index:int):void
		{
			if (event.type == MouseEvent.CLICK)
			{
				bookType = index;
				dispatchEvent(new CompEvent(CompEvent.SELECT, {requestType:"PictureMaterialProxy",btypeid:picList.dataSource[index].bookTypeId, booklib:picList.dataSource[index].id, pixel:"2072*1256", picType:TYPE[tabThumb.selectedIndex]}))
			}
		}
	}
	

}