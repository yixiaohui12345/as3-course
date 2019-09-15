package frameworks.view.preview 
{
	import flash.display.Shape;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import frameworks.model.PageConfig;
	import frameworks.view.design.LeftPanel;
	import morn.core.components.Box;
	import morn.core.components.Image;
	import morn.core.components.Label;
	import morn.core.components.Panel;
	import morn.core.components.law.EPage;
	import morn.core.events.UIEvent;
	/**
	 * ...
	 * @author yxh
	 */
	public class Preview extends Panel
	{
		private var shape:Shape = new Shape();
		
		private var pageIndex:int = 0;
		
		private var pageList:Vector.<EPage>
		
		private var tips:Label = null;
		
		private var box:Box = null;
		
		private var boxMask:Shape
		
		private var bg:Shape = new Shape()
		
		private var mouseCacheCount:int = 0;
		
		public function Preview() 
		{
			tips = new Label();
			tips.background = true;
			tips.backgroundColor = 0xcccccc;
			tips.color = 0xffffff;
			
			tips.height = 100;
			tips.size = 60;
			tips.font = "微软雅黑";
			tips.align = "center"
			
			box = new Box();
			addChild(box);
			boxMask = new Shape();
			boxMask.graphics.beginFill(0);
			boxMask.graphics.drawRect(0.5 * (App.stage.stageWidth - PageConfig.PAGE_WIDTH), 0.5 * (App.stage.stageHeight - PageConfig.PAGE_HEIGHT), PageConfig.PAGE_WIDTH, PageConfig.PAGE_HEIGHT);
			boxMask.graphics.endFill();
			box.mask = boxMask;
			box.addChild(boxMask);
			
			addChildAt(bg, 0);
		}
		
		public function resize():void
		{
			this.x = 0;
			this.y = 0;
			this.width = App.stage.stageWidth;
			this.height = App.stage.stageHeight;
			
			bg.graphics.clear();
			bg.graphics.beginFill(0);
			bg.graphics.drawRect(0,0, App.stage.stageWidth, App.stage.stageHeight);
			bg.graphics.endFill()
			
			tips.width = App.stage.stageWidth;
			tips.y = App.stage.stageHeight - 150;
			
			
		}
		
		private function onWheel(e:MouseEvent):void 
		{
			trace(e.delta);
			if (mouseCacheCount>=2){
				close();
				return 
			}
			if (e.delta > 0){
				playPre()
			}
			else{
				playNext();
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.LEFT:
					playPre();
					break;
				case Keyboard.RIGHT:
					playNext();
					break;
				case Keyboard.ESCAPE:
					close();
					break;
			}
		}
		
		private function close():void 
		{
			mouseCacheCount = 0;
			App.timer.clearTimer(hideTips);
			App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			App.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.remove();
		}
		
		public function update(vector:Vector.<EPage>):void
		{
			App.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			App.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel, false, 0, true);
			mouseCacheCount = 0;
			pageIndex = 0;
			pageList=vector
			box.addChild(vector[pageIndex]);
			vector[pageIndex].addEventListener(UIEvent.LINK, linkHandler);
			pageList[pageIndex].x = (this.width - PageConfig.PAGE_WIDTH) * .5;
			pageList[pageIndex].y = (this.height - PageConfig.PAGE_HEIGHT) * .5;
			showTips("请使用← →控制播放或者鼠标滑轮")
		}
		
		public function playNext():void
		{
			hideTips();
			if (pageIndex<pageList.length)
			{
				if (!pageList[pageIndex].playNext())
				{
					if (pageIndex <pageList.length - 1)
					{
						pageIndex++;
						pageList[pageIndex].x = (this.width - PageConfig.PAGE_WIDTH) * .5;
						pageList[pageIndex].y = (this.height - PageConfig.PAGE_HEIGHT) * .5;
						pageList[pageIndex].visible = true;
						pageList[pageIndex].addEventListener(UIEvent.LINK, linkHandler);
						box.addChild(pageList[pageIndex])
					}
					else
					{
						mouseCacheCount++;
						showTips("完成播放可按Esc退出");
					}
				}
			}
			else
			{
				pageIndex = pageList.length - 1;
				mouseCacheCount++;
				showTips("完成播放可按Esc退出");
			
			}
		}
		
		public function playPre():void
		{
			hideTips();
			if (pageList[pageIndex])
			{
				if (!pageList[pageIndex].playPre())
				{
					if (pageIndex > 0)
					{
						box.removeChild(pageList[pageIndex]);
						pageIndex--;
						pageList[pageIndex].visible = true;
					}
				}
			}
		}
		
		private function linkHandler(e:UIEvent):void
		{
			if (e.data && e.data.url&&!isNaN(Number(e.data.url)))
			{
				var index:int = int(e.data.url)
				for (var i:int = 0, len:int = pageList.length; i < len; i++)
				{
					if (i == index)
					{
						if (!pageList[i].parent)
						{
							box.addChild(pageList[i]);
							pageList[i].x = (this.width - PageConfig.PAGE_WIDTH) * .5;
							pageList[i].y = (this.height - PageConfig.PAGE_HEIGHT) * .5;
						}
						pageList[i].visible = true;
						pageIndex = i;
					}
					else
					{
						pageList[i].visible = false;
					}
				}
			}
		}
		
		public function showTips(content:String):void
		{
			tips.text = content;
			addChild(tips);
			if (mouseCacheCount>=2){
				close();
			}
			App.timer.doOnce(2000, hideTips,[content]);
		}
		
		private function hideTips(content:String=null):void 
		{
			App.timer.clearTimer(hideTips);
			tips.remove();
		}
		
		override public function dispose():void
		{
			if (pageList)
			{
				for (var i:int = 0, len:int = pageList.length; i < len; i++)
				{
					pageList[i] && pageList[i].dispose();
					pageList[i] &&pageList[i].remove();
					pageList[i] = null;
				}
				pageList.length = 0;
			}
		}
	}
}