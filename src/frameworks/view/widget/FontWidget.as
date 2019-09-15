package frameworks.view.widget 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import frameworks.events.CompEvent;
	import frameworks.view.widget.item.FontAlign;
	import frameworks.view.widget.item.FontFormat;
	import frameworks.view.widget.item.FontStyle;
	import morn.core.components.ColorPicker;
	import morn.core.components.FreeCombobox;
	import morn.core.components.ImageRadioGroup;
	import morn.core.components.SimpleSlider;
	import morn.core.components.law.EText;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import skin.widget.FontWidgetUI;
	/**
	 * ...
	 * @author yxh
	 */
	public class FontWidget extends FontWidgetUI
	{
		public var sliderSize:SimpleSlider = null;
		
		public var sliderIndent:SimpleSlider = null;
		
		public var sliderRotate:SimpleSlider = null;
		
		public var sliderLeading:SimpleSlider = null;
		
		public var sliderSpace:SimpleSlider = null;
		
		public var fontAlign:FontAlign = null;
		
		public var fontStyle:FontStyle = null;
		
		public var fontFormat:FontFormat = null;
		
		public var buttonFormat:FreeCombobox = null;
		
		public var buttonStyle:FreeCombobox = null;
		
		public var buttonAlign:FreeCombobox = null;
		
		private static const ALIGN:Array = ["left", "center", "right"];
		
		public function FontWidget() 
		{
			var temp:Array = Font.enumerateFonts(true);
			var temp2:Array = [];
			for (var i:int = 0,n:int=temp.length;i < n; i++)
			{
				temp2.push(temp[i].fontName);
			}
			fontFamily.labels = temp2.join();
			fontFamily.selectedLabel = "微软雅黑";
			temp.length = 0; temp = null; temp2.length = 0; temp2 = null;
			
			fontStyle = new FontStyle();
			buttonStyle = new FreeCombobox("png.style.combobox.font_style");
			buttonStyle.contentView=fontStyle
			fontStyle.list.dataSource = [{skin:"png.style.icon.bold", label:"加粗"}, {skin:"png.style.icon.italic", label:"斜体"}, {skin:"png.style.icon.underline", label:"下划线"}]
			fontStyle.list.renderHandler = new Handler(fontStyleRender);
			fontStyle.list.mouseHandler = new Handler(fontStyleMouse);
			addChild(buttonStyle);
			
			fontAlign = new FontAlign();
			buttonAlign = new FreeCombobox("png.style.combobox.font_align");
			buttonAlign.contentView = fontAlign;
			fontAlign.list.dataSource=[{skin:"png.style.icon.left", label:"左对齐"}, {skin:"png.style.icon.center", label:"居中"}, {skin:"png.style.icon.right", label:"右对齐"}]
			fontAlign.list.renderHandler = new Handler(fontAlignRender);
			fontAlign.list.mouseHandler = new Handler(fontAlignMouse);
			addChild(buttonAlign);
			
			fontFormat = new FontFormat();
			buttonFormat = new FreeCombobox("png.style.combobox.font_format");
			buttonFormat.contentView = fontFormat;
			addChild(buttonFormat);
			
			buttonStyle.x = 250;
			buttonAlign.x = 300;
			buttonFormat.x = 350
			buttonFormat.centerY = buttonStyle.centerY = buttonAlign.centerY = 0;
			
			 sliderSize = new SimpleSlider(); sliderIndent = new SimpleSlider(); sliderLeading = new SimpleSlider();  sliderSpace = new SimpleSlider(); sliderRotate = new SimpleSlider();
			 sliderSize.skin = sliderIndent.skin = sliderLeading.skin =  sliderSpace.skin =  "png.style.icon.border";
			//sizeGrid
			sliderSize.sizeGrid = sliderIndent.sizeGrid = sliderLeading.sizeGrid = sliderSpace.sizeGrid =  "2,2,43,2";
			//hint
			sliderSize.hint = sliderIndent.hint = sliderLeading.hint =  sliderSpace.hint = "px"; 
		
			sliderSize.max = 160; sliderSize.min = 10;
			sliderIndent.max = 30; sliderIndent.min = 0;
			sliderLeading.max = 30; sliderIndent.min = 0;
			sliderSpace.max = 30; sliderSpace.min = 0;
			sliderIndent.x = sliderSpace.x = sliderLeading.x =  70; sliderSize.x = 120;
			sliderIndent.y = 70; sliderSpace.y = 10; sliderLeading.y = 40;
			sliderSize.labelSize = sliderIndent.labelSize = sliderLeading.labelSize =  sliderSpace.labelSize =  15;
			sliderIndent.value = 0; sliderLeading.value = 0; sliderSize.value = 16; sliderSpace.value = 0;
			
			addChild(sliderSize); 
			sliderSize.height = 28;
			sliderSize.y = 3.5;
			fontFormat.addChild(sliderIndent); 
			fontFormat.addChild(sliderLeading); 
			fontFormat.addChild(sliderSpace); 
			
			fontColor.addEventListener(UIEvent.SELECT_COLOR, fontColorChange);
			fontFamily.addEventListener(Event.CHANGE, fontFamilyChange);
			sliderSize.addEventListener(UIEvent.SCROLL_END, fontSizeChange);
			sliderIndent.addEventListener(UIEvent.SCROLL_END, fontIndentChange);
			sliderLeading.addEventListener(UIEvent.SCROLL_END, fontLeadingChange);
			sliderSpace.addEventListener(UIEvent.SCROLL_END, fontSpaceChange);
		}
		
		public function update(data:Object):void
		{
			if (data && data is EText)
			{
				sliderSize.value = Number(EText(data).size);
				fontFamily.selectedLabel = EText(data).font;
				fontColor.selectedColor = Number(EText(data).color);
				sliderLeading.value = Number(EText(data).leading);
				sliderIndent.value = Number(EText(data).indent);
				sliderSpace.value = Number(EText(data).letterSpacing);
			}
		}
		
		private function fontSpaceChange(e:UIEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"letterSpacing", value:sliderSpace.value}));
		}
		
		private function fontLeadingChange(e:UIEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"leading", value:sliderLeading.value}));
		}
		
		private function fontIndentChange(e:UIEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"intent", value:sliderIndent.value}));
		}
		
		private function fontSizeChange(e:UIEvent):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"size", value:sliderSize.value}));
		}
		
		private function fontFamilyChange(e:Event):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"font", value:fontFamily.selectedLabel}));
		}
		
		private function fontColorChange(e:Event):void 
		{
			dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY,{key:"color",value:fontColor.selectedColor}))
		}
		
		private function fontAlignRender(cell:*, index:int):void
		{
			if (index < fontAlign.list.dataSource.length)
			{
				cell.icon.url = fontAlign.list.dataSource[index].skin;
				cell.label_icon.text = fontAlign.list.dataSource[index].label;
			}
		}
		
		private function fontAlignMouse(event:MouseEvent, index:int):void
		{
			if (event.type == MouseEvent.CLICK)
			{
				buttonAlign.isOpen = false;
				dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"align", value:ALIGN[index]}));
			}
		}
		
		private function fontStyleRender(cell:*, index:int):void
		{
			if (index < fontStyle.list.dataSource.length)
			{
				cell.icon.url = fontStyle.list.dataSource[index].skin;
				cell.label_icon.text = fontStyle.list.dataSource[index].label;
			}
		}
		
		private function fontStyleMouse(event:MouseEvent, index:int):void
		{
			if (event.type == MouseEvent.CLICK)
			{
				buttonStyle.isOpen = false;
				switch(index)
				{
					case 0:
						dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"bold",value:null}));
						break
					case 1:
						dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"italic",value:null}));
						break
					case 2:
						dispatchEvent(new CompEvent(CompEvent.CHANGE_PROPERTY, {key:"underline",value:null}));
						break;
				}
				
			}
		}
		
		private function onFontStyle(e:MouseEvent):void 
		{
			fontStyle.visible = !fontStyle.visible;
		}
		
		private function onFontAlign(e:MouseEvent):void
		{
			fontAlign.visible = !fontAlign.visible;
		}
		
		private function onFontFormat(e:MouseEvent):void
		{
			fontFormat.visible = !fontFormat.visible;
		}
		
	}

}