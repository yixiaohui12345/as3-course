package frameworks.view.design 
{
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import frameworks.model.command.CommandManager;
	import frameworks.model.vo.PageVO;
	import morn.core.components.law.EPage;
	import skin.panel.CanvasUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class Canvas extends CanvasUI
	{
		private var currentPage:EPage
		
		private var shapeMask:Shape = null;
		
		public function Canvas() 
		{
			shapeMask = new Shape();
			this.mask = shapeMask;
			addChildAt(shapeMask,0);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, mouseDown);
		}
		
		public function updatePage(data:Object):void{
			if (data&&data.page){
				this.currentPage = data.page as EPage;
			}
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			currentPage && currentPage.startDrag(false);
			App.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, mouseUp);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			App.stage.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, mouseUp);
			currentPage && currentPage.stopDrag();
		}
		
		private function mouseWheel(e:MouseEvent):void 
		{
			var delta:Number = e.delta > 0?0.01: -0.01;
			var temp:Number = currentPage.scale+delta;
			temp = temp >= 4?4:(temp <= 0.4?0.4:temp);
			currentPage.scale = temp
			dispatchEvent(new CompEvent(CompEvent.CHANGE_SCALE, temp));
			resizePage();
		}
		
		public function addPage(vo:PageVO):void
		{
			currentPage=vo.page
			addChild(currentPage);
			if (vo.index > 0)
			{
				CommandManager.inst.Add(this, currentPage);
			}
			resizePage();
		}
		
		public function resize():void
		{
			this.x = 170;
			this.y = 40;
			this.width = App.stage.stageWidth - 170
			this.height = App.stage.stageHeight - 40
			graphics.clear();
			graphics.beginFill(0x282828);
			graphics.drawRect(0, 0, App.stage.stageWidth - 170, App.stage.stageHeight - 40);
			graphics.endFill();
			
			shapeMask.graphics.clear();
			shapeMask.graphics.beginFill(0);
			shapeMask.graphics.drawRect(0, 0, width, height);
			shapeMask.graphics.endFill();
			
			resizePage()
		}
		
		public function resizePage():void 
		{
			if (currentPage == null)
			{
				return
			}
			currentPage.x = (width - currentPage.width*currentPage.scale) * .5;
			currentPage.y = (height - currentPage.height*currentPage.scale) * .5;
		}
	}

}