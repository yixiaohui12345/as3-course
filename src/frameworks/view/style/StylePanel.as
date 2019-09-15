package frameworks.view.style 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import frameworks.events.CompEvent;
	import frameworks.message.OperateType;
	import frameworks.model.command.DisposeUtil;
	import frameworks.view.widget.Alert;
	import morn.core.components.SimpleSlider;
	import morn.core.components.law.EComponent;
	import morn.core.components.law.EType;
	import mouse.MouseType;
	import org.utils.RegExpUtils;
	import skin.panel.StylePanelUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class StylePanel extends StylePanelUI
	{
		public var sliderRotate:SimpleSlider = null;
		
		public var sliderSize:SimpleSlider = null;
		
		public var sliderAlpha:SimpleSlider = null;
		
		public function StylePanel() 
		{
			sliderRotate = new SimpleSlider();
			sliderSize = new SimpleSlider();
			sliderAlpha = new SimpleSlider();
			
			sliderAlpha.skin=sliderSize.skin = sliderRotate.skin = "png.style.icon.border";
			sliderAlpha.sizeGrid=sliderSize.sizeGrid = sliderRotate.sizeGrid = "4,2,43,2";
			sliderAlpha.labelSize = sliderSize.labelSize = sliderRotate.labelSize = 15;
			sliderAlpha.labelColor = sliderSize.labelColor = sliderRotate.labelColor = 0x666666;
			sliderAlpha.mouseStyle = sliderSize.mouseStyle = sliderRotate.mouseStyle = MouseType.MOUSE_VERTICAL;
			
			sliderRotate.min =-180;
			sliderRotate.max = 180;
			sliderSize.min = 10;
			sliderSize.max = 400;
			
			sliderRotate.hint = "°";
			sliderAlpha.hint = sliderSize.hint = "%";
			
			sliderAlpha.value = sliderSize.value = 100;
			sliderRotate.value=0
			
			sliderRotate.x = sliderAlpha.x = sliderSize.x = 85;
			sliderRotate.y = 37.5;
			sliderSize.y = 77.5;
			sliderAlpha.y = 117.5;
			
			radioGroup.selectedIndex = 0;
			
			addChild(sliderRotate)
			addChild(sliderSize)
			addChild(sliderAlpha)
		}
		
		public function resize():void
		{
			this.x = App.stage.stageWidth - 360
			this.y = 40;
		}
		
		public function onUpdate(comp:EComponent,total:int):void
		{
			resize();
			if (comp)
			{
				if (comp.link && comp.link.length > 0)	
					radioGroup.selectedIndex = comp.link.indexOf("Net") >-1?1:2;
				else
					radioGroup.selectedIndex = 0;
				
				if (comp.type == EType.TEXT)
				{
					sliderRotate.value=comp.rotationZ
				}
				else
				{
					sliderRotate.value = comp.rotation;
				}
				sliderAlpha.value = comp.alpha * 100;
				sliderSize.value = comp.scale * 100;
			}
			
			label_link.visible = false;
			label_link.hint = "请输入类似如下网址:http://www.deyuedu.com";
			label_link.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			
			radioGroup.addEventListener(Event.CHANGE, onLinkChange, false, 0, true);
			
			combobox_link.visible = false;
			combobox_link.addEventListener(Event.CHANGE, onPageChange);
			
			var temp:Array=[]
			for (var i:int = 0; i < total; i++)
			{
				temp.push("跳转第" + String(i + 1) + "页");
			}
			combobox_link.labels = temp.join();
			temp = null;
		}
		
		private function onFocusOut(e:FocusEvent):void 
		{
			if (RegExpUtils.checkNet(label_link.text))
			{
				var obj:Object = {};
				obj.type = "Net";
				obj.url = label_link.text;
				dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {type:OperateType.MODIFY, key:"link", value:JSON.stringify(obj)}));
				DisposeUtil.Dispose(obj);
			}
			else
			{
				Alert.inst.show("请输入正确网址");
			}
		}
		
		private function onPageChange(e:Event):void 
		{
			var obj:Object = {};
			obj.type = "Page";
			obj.url = combobox_link.selectedIndex
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {type:OperateType.MODIFY, key:"link", value:JSON.stringify(obj)}));
			DisposeUtil.Dispose(obj);
		}
		
		public function onHide():void
		{
			radioGroup.removeEventListener(Event.CHANGE, onLinkChange);
		}
		
		private function onLinkChange(e:Event):void 
		{
			switch(radioGroup.selectedIndex)
			{
				case 0:
					combobox_link.visible = false;
					label_link.visible = false;
					dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {type: OperateType.MODIFY,key:"link", value:null}));
					break;
				case 1:
					combobox_link.visible = false;
					label_link.visible = true;
					break;
				case 2:
					combobox_link.visible = true;
					label_link.visible = false;
					break;
			}
		}
	}
}