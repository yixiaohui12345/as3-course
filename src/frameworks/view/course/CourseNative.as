package frameworks.view.course 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.common.Source;
	import frameworks.events.AppEvent;
	import frameworks.events.CompEvent;
	import frameworks.message.OperateType;
	import frameworks.view.widget.Alert;
	import morn.core.components.SmartTab;
	import morn.core.handlers.Handler;
	import org.utils.DateUtils;
	import skin.dialog.CourseNativeUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class CourseNative extends CourseNativeUI
	{
		public var tab:SmartTab = null;
		
		
		public function CourseNative() 
		{
			tab = new SmartTab(Source.SUBJECT.join(), "png.style.button.normal");
			tab.x = 60;
			tab.y =58
			tab.showNum =15
			tab.space = 5;
			tab.labelColors = "0x666666,0xffffff,0xffffff,0x666666";
			addChild(tab);
			courseList.visible = false;
			courseList.renderHandler = new Handler(renderHandler);
			courseList.mouseHandler = new Handler(mouseHandler);
			checkbox_select.addEventListener(Event.CHANGE, btn_auto_click);
		}
		
		private function btn_auto_click(e:Event):void 
		{
			tab.open = !tab.open;
		}
		
		private function mouseHandler(event:MouseEvent, index:int):void
		{
			if (event.type == MouseEvent.CLICK)
			{
				dispatchEvent(new CompEvent(CompEvent.PREVIEW, {type:OperateType.DOWNLOAD_COURSE,id:courseList.dataSource[index].id}));
			}
		}
		
		private function renderHandler(cell:*, index:int):void
		{
			if (index < courseList.dataSource.length)
			{
				cell.label.text = courseList.dataSource[index].title;
				cell.label_date.text="创建日期:  "+DateUtils.getDateString(DateUtils.getDateTime(courseList.dataSource[index].createDate["time"]))
				cell.label_page.text = "总页数:  " + courseList.dataSource[index].pageCount + "页";
			}
		}
		
		public function updateCourse(data:Object):void
		{
			if (data && data.list && data.list.length > 0)
			{
				courseList.visible = true;
				var list:Array = data.list;
				courseList.dataSource = list;
				label_page.text = String(data.pagenow) + "/" + String(data.pageAll);
			}
			else
			{
				if (data)
				{
					label_page.text = String(data.pagenow) + "/" + String(data.pageAll);
				}
				
				courseList.visible = false;
				Alert.inst.show("暂时无数据");
			}
		}
		
		public function resize():void
		{
			label_search.hint = "请输入要搜索的课件名";
			tab.selectedIndex = 0;
			this.width = App.stage.stageWidth;
			this.height = App.stage.stageHeight;
			
			graphics.clear();
			graphics.beginFill(0xffffff);
			graphics.drawRect(0, 0, App.stage.stageWidth, App.stage.stageHeight);
			graphics.endFill();
			
			search_box.updatePosition()
			courseList.updatePosition();
		}
		
		public function onUpdate():void
		{
			dispatchEvent(new AppEvent(AppEvent.UPDATE));
		}
	}

}