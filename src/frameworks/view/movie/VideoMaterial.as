package frameworks.view.movie 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import frameworks.model.vo.MovieVO;
	import morn.core.components.FreeTab;
	import morn.core.handlers.Handler;
	import skin.dialog.VideoMaterialUI;
	import frameworks.common.Source;
	/**
	 * ...
	 * @author yxh
	 */
	public class VideoMaterial extends VideoMaterialUI
	{
		public var tabFree:FreeTab = null;
		
		public function VideoMaterial() 
		{
			tabFree = new FreeTab(Source.PN_LIST.join(), "png.style.tab.free");
			tabFree.selectedIndex = 0;
			tabFree.x = 5;
			tabFree.y = 10;
			tabFree.space = 2;
			tabFree.row = 5;
			tabFree.labelColors = "0xcccccc,0xffffff,0xffffff,0xcccccc";
			addChild(tabFree);
			
			videoList.renderHandler = new Handler(renderHandler);
			videoList.mouseHandler = new Handler(mouseHandler);	
			label_tips.visible = false;
		}
		
		public function updateList(vo:MovieVO):void
		{
			if (vo.bookList == null || vo.bookList.length == 0)
			{
				label_tips.visible = true;
				videoList.visible = false;
			}
			else
			{
				label_tips.visible = false;
				videoList.visible = true;
				videoList.dataSource = vo.bookList;
			}
		}
		
		private function mouseHandler(event:MouseEvent, index:int):void
		{
			
		}
		
		private function renderHandler(cell:*, index:int):void
		{
			if (index < videoList.dataSource.length)
			{
				cell.icon.url = "png/" + videoList.dataSource[index].id + ".png";
				cell.icon.name=videoList.dataSource[index].id
				cell.icon.doubleClickEnabled = true;
				cell.icon.addEventListener(MouseEvent.DOUBLE_CLICK, insertMovie);
				cell.label.text = videoList.dataSource[index].description;
				cell.toolTip = "双击导入视频";
			}
		}
		
		private function insertMovie(e:MouseEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.LOAD_VCR,NetConfig.MTL_URL+"/"+NetConfig.SWF+"/"+e.currentTarget.name+".swf"));
		}
		
	}

}