package frameworks.view.design 
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import frameworks.model.vo.PageVO;
	import frameworks.view.widget.item.PageItemRender;
	import morn.core.components.Component;
	import morn.core.components.law.EPage;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import skin.panel.LeftPanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class LeftPanel extends LeftPanelUI
	{
		
		public function LeftPanel() 
		{
			imageList.renderHandler = new Handler(renderHandler);
			imageList.mouseHandler = new Handler(mouseHandler);
		}
		
		private function mouseHandler(event:MouseEvent,index:int):void 
		{
			if (event.type == MouseEvent.CLICK)
			{
				var len:int = imageList.cells?imageList.cells.length+imageList.startIndex:0;
				trace("cell: length:  " + len);
				for (var i:int = imageList.startIndex; i < len; i++)
				{
					var cell:PageItemRender = imageList.getCell(i) as PageItemRender;
					if (i == index)
					{
						cell.isSelected = true;
					}
					else
					{
						cell.isSelected = false;
					}
				}
				dispatchEvent(new CompEvent(CompEvent.SHOW_PAGE, {index:index}));
			}
		}
		
		public function resize():void
		{
			this.height = App.stage.stageHeight - 40;
			for (var i:int = 0; i < this.numChildren; i++)
			{
				(this.getChildAt(i) as Component).updatePosition();
			}
		}
		
		public function updateThumb(data:Object):void
		{
			var index:int = data.index;
			var bmd:BitmapData = data.bmd;
			var box:PageItemRender = imageList.getCell(index) as PageItemRender;
			if (box&&bmd)
			{
				box.icon.bitmapData = bmd;
			}
		}
		
		private var thumbArr:Array = null;
		public function updateVO(vector:Vector.<PageVO>,curIndex:int,bitmapArr:Array):void
		{
			var arr:Array = [];
			_currentIndex = curIndex;
			thumbArr=bitmapArr
			for (var i:int = 0; i < vector.length; i++)
			{
				var bmd:BitmapData = new BitmapData(vector[i].page.width, vector[i].page.height, true, 0xffffff);
				bmd.draw(vector[i].page);
				arr.push({bmd:bmd});
			}
			imageList.dataSource = arr;
		}
		
		private function renderHandler(cell:PageItemRender, index:int):void
		{
			if (index < imageList.dataSource.length)
			{
				if (index == _currentIndex)
				{
					cell.isSelected = true
				}
				else
				{
					cell.isSelected = false;
				}
				cell.btn_delete.name = index.toString();
				cell.label.text = String(index + 1);
				if (thumbArr && thumbArr[index])
				{
					cell.icon.bitmapData = thumbArr[index];
				}
				cell.btn_delete.addEventListener(MouseEvent.CLICK, handleDelete);
			}
		}
		
		private function handleDelete(e:MouseEvent):void 
		{
			var deleteIndex:int = int(e.currentTarget.name);
			imageList.deleteItem(deleteIndex);
			trace("删除index: " + deleteIndex + " 幻灯片");
			dispatchEvent(new CompEvent(CompEvent.DELETE_PAGE, {index:deleteIndex,target:this}));
			e.stopPropagation();
		}
		
		private var _currentIndex:int = 0;
		public function set currentIndex(value:int):void{
			if (_currentIndex != value){
				var cell:PageItemRender = null;
				if (_currentIndex-imageList.startIndex<0){
					return;
				}
				cell = (imageList.getCell(_currentIndex) as PageItemRender)
				cell && (cell.isSelected = false);
				cell = null;
				if (value-imageList.startIndex < 0){
					return 
				}
				_currentIndex = value;
				cell = (imageList.getCell(value) as PageItemRender);
				cell && (cell.isSelected = true);
			}
		}
		
		public function get currentIndex():int{
			return _currentIndex
		}
		
		override public function dispose():void
		{
			imageList.removeAllChild();
			super.dispose();
		}
	}
}
