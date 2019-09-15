package frameworks.view.blocks 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import frameworks.events.CompEvent;
	import frameworks.message.OperateType;
	import frameworks.view.widget.Alert;
	import morn.core.components.Component;
	import morn.core.handlers.Handler;
	import skin.widget.blocks.BackGroundBlockUI;
	import morn.core.components.ColorMixer;
	import morn.core.events.UIEvent;
	import org.utils.ColorUtils;
	/**
	 * ...
	 * @author yxh
	 */
	public class BackGroundBlock extends BackGroundBlockUI
	{
		protected var colorMixer:ColorMixer = null;
		
		protected var showColor:Shape = new Shape();
			
		public function BackGroundBlock() 
		{
			
			
			colorMixer = new ColorMixer();
			colorMixer.centerX = 0;
			colorMixer.addEventListener(UIEvent.SELECT_COLOR, onSelectColor);
			colorPanel.label_b.addEventListener(Event.CHANGE, onRGBChange);
			colorPanel.label_g.addEventListener(Event.CHANGE, onRGBChange);
			colorPanel.label_r.addEventListener(Event.CHANGE, onRGBChange);
			colorPanel.label_baohedu.addEventListener(Event.CHANGE, onHSLChange);
			colorPanel.label_liangdu.addEventListener(Event.CHANGE, onHSLChange);
			colorPanel.label_sediao.addEventListener(Event.CHANGE, onHSLChange);
			colorPanel.addChild(colorMixer);
			colorPanel.btn_modify.addEventListener(MouseEvent.CLICK, onModifyEvent);
			colorPanel.visible = thumbList.visible = false;
			
			colorPanel.addChild(showColor);
			showColor.x = 5;
			
			radioGroup.selectedIndex = 0;
			radioGroup.addEventListener(Event.CHANGE, onGroupItemChange);
			
			thumbList.renderHandler = new Handler(renderHandler);
			var arr:Array = [];
			for (var i:int = 1; i <= 10; i++)
			{
				arr.push({url:"bg/"+i+".jpg"})
			}
			thumbList.dataSource = arr;
		}
		
		private function onModifyEvent(e:MouseEvent):void 
		{
			var color:uint = ColorUtils.rgbToNumber(int(colorPanel.label_r.text), int(colorPanel.label_g.text), int(colorPanel.label_b.text));
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {type:OperateType.MODIFY_PAGE, key:"scene", value:color}));
		}
		
		protected function renderHandler(cell:*, index:int):void
		{
			if (index < thumbList.dataSource.length)
			{
				cell.icon.url = thumbList.dataSource[index].url;
				(cell as Component).doubleClickEnabled = true;
				cell.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleEvent);
			}
		}
		
		private function onDoubleEvent(e:MouseEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {type:OperateType.MODIFY_PAGE, key:"scene", value:e.currentTarget.icon.url}));
		}
		
		private function onGroupItemChange(e:Event):void 
		{
			switch(radioGroup.selectedIndex)
			{
				case 0:
					colorPanel.visible = thumbList.visible = false;
					dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {type:OperateType.MODIFY_PAGE, key:"scene", value:null}));
					break
				case 1:
					thumbList.visible = false
					colorPanel.visible = true;
					break;
				case 2:
					thumbList.visible = true
					colorPanel.visible = false;
					break;
			}
		}
		
		private function onHSLChange(e:Event):void 
		{
			var h:int = int(colorPanel.label_sediao.text);
			var s:int = int(colorPanel.label_baohedu.text);
			var l:int = int(colorPanel.label_liangdu.text);
			
			if (h<0||h>255||s<0||s>255||l<0||l>255)
			{
				Alert.inst.show("超出范围值");
				e.currentTarget.text="0"
			}
			else
			{
				var arr:Array=ColorUtils.getRgb(h, s, l);
				var color:uint = ColorUtils.rgbToNumber(arr[0], arr[1], arr[2]);
				drwaShowColor(color);
			}
		}
		
		private function drwaShowColor(color:uint):void
		{
			showColor.graphics.clear();
			showColor.graphics.beginFill(color);
			showColor.graphics.drawRect(0, 0, 30, 30);
			showColor.graphics.endFill();
		}
		
		private function onRGBChange(e:Event):void 
		{
			var r:int = int(colorPanel.label_r.text);
			var g:int = int(colorPanel.label_g.text);
			var b:int = int(colorPanel.label_b.text);
			
			if (r<0||r>255||g<0||g>255||b<0||b>255)
			{
				Alert.inst.show("超出范围值");
				e.currentTarget.text="0"
			}
			else
			{
				var color:uint = ColorUtils.rgbToNumber(r,g,b);
				drwaShowColor(color);
			}
		}
		
		private function onSelectColor(e:UIEvent):void 
		{
			updateByColor(colorMixer.selectColor);
		}
		
		protected function updateByColor(color:uint):void
		{
			var arr:Array = ColorUtils.toARGB(color);
			if (arr&&arr.length>0)
			{
				colorPanel.label_r.text = arr[0];
				colorPanel.label_g.text = arr[1];
				colorPanel.label_b.text = arr[2];
				var hsv:Array = ColorUtils.rToH(arr[0], arr[1], arr[2]);
				colorPanel.label_sediao.text =Number(hsv[0]).toFixed(0); 
				colorPanel.label_baohedu.text =Number(hsv[1]).toFixed(0);
				colorPanel.label_liangdu.text = Number(hsv[2]).toFixed(0);
				drwaShowColor(color);
			}
		}
	}

}