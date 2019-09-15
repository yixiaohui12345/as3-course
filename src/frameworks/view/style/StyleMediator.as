package frameworks.view.style 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import frameworks.events.CompEvent;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.PageProxy;
	import morn.core.components.law.EComponent;
	import morn.core.components.law.EType;
	import morn.core.events.UIEvent;
	import mvcexpress.mvc.Mediator;
	/**
	 * ...
	 * @author yxh
	 */
	public class StyleMediator extends Mediator
	{
		[Inject]
		public var view:StylePanel
		
		public function StyleMediator() 
		{
			
		}
		
		override protected function onRegister():void
		{
			addListener(view.sliderAlpha, UIEvent.SCROLL_END, alphaChange);
			addListener(view.sliderRotate, UIEvent.SCROLL_END, rotateChange);
			addListener(view.sliderSize, UIEvent.SCROLL_END, scaleChange);
			addListener(view.btn_rotate_left, MouseEvent.CLICK, rotateAntiWise);
			addListener(view.btn_rotate_right, MouseEvent.CLICK, rotateWise);
			addListener(view.btn_rotate_x, MouseEvent.CLICK, rotateHorizon);
			addListener(view.btn_rotate_y, MouseEvent.CLICK, rotateVertical);
			addListener(view.btn_copy, MouseEvent.CLICK,handleCopy);
			addListener(view.btn_down, MouseEvent.CLICK, handleDowner);
			addListener(view.btn_downest, MouseEvent.CLICK, handleDownest);
			addListener(view.btn_up, MouseEvent.CLICK, handleUpper);
			addListener(view.btn_uppest, MouseEvent.CLICK, handleUppest);
			addListener(view.btn_restore, MouseEvent.CLICK, handleRestore);
			addListener(view, CompEvent.CHANGE_PROPERTY, handleChange);
		}
		
		private function handleChange(e:CompEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, e.data);
		}
		
		private function alphaChange(e:Event):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "alpha", value: view.sliderAlpha.value * 0.01});
		}
		
		private function rotateChange(e:Event):void
		{
			if (pageProxy&&pageProxy.currentHitTarget)
			{
				if (pageProxy.currentHitTarget.type == EType.IMAGE)
				{
					sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotation", value: view.sliderRotate.value});
				}
				else if(pageProxy.currentHitTarget.type==EType.TEXT)
				{
					sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotationZ", value: view.sliderRotate.value});
				}
			}
		}
		
		private function scaleChange(e:Event):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "scale", value: view.sliderSize.value * 0.01});
		}
		
		private function handleRestore(e:MouseEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.OPERATE, action: OperateType.RESTORE});
		}
		
		private function handleUppest(e:MouseEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.OPERATE, action: OperateType.UPPEST});
		}
		
		private function handleUpper(e:MouseEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.OPERATE, action: OperateType.UPPER});
		}
		
		private function handleDownest(e:MouseEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.OPERATE, action: OperateType.DOWNEST});
		}
		
		private function handleDowner(e:MouseEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.OPERATE, action: OperateType.DOWNER});
		}
		
		private function handleCopy(e:MouseEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.OPERATE, action: OperateType.COPY});
		}
		
		private function rotateVertical(e:MouseEvent):void
		{
			if (pageProxy && pageProxy.currentHitTarget && pageProxy.currentPage.currentHitTarget.type == EType.IMAGE)
			{
				var value:Number = pageProxy.currentHitTarget.rotationY
				value -= 180;
				sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotationY", value: value});
			}
		}
		
		private function rotateHorizon(e:MouseEvent):void
		{
			if (pageProxy &&pageProxy.currentHitTarget && pageProxy.currentHitTarget.type == EType.IMAGE)
			{
				var value:Number = pageProxy.currentHitTarget.rotationX
				value -= 180;
				sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotationX", value: value});
			}
		}
		
		private function rotateWise(e:MouseEvent):void
		{
			if (pageProxy&&pageProxy.currentHitTarget)
			{
				var value:Number
				if (pageProxy.currentHitTarget.type == EType.IMAGE)
				{
					value = pageProxy.currentHitTarget.rotation;
					value += 90;
					switch(value % 360)
					{
						case 0:
							value = 0;
							break
						case 90:
							value=90
							break;
						case 180:
							value=180
							break;
						case 270:
							value=-90
							break
					}
					sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotation", value: value});
				}
				else if(pageProxy.currentHitTarget.type==EType.TEXT)
				{
					value = pageProxy.currentHitTarget.rotationZ;
					value += 90;
					switch(value % 360)
					{
						case 0:
							value = 0;
							break
						case 90:
							value=90
							break;
						case 180:
							value=180
							break;
						case 270:
							value=-90
							break
					}
					sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotationZ", value: value});
				}
			}
		}
		
		private function rotateAntiWise(e:MouseEvent):void
		{
			if (pageProxy&&pageProxy.currentHitTarget)
			{
				var value:Number
				if (pageProxy.currentHitTarget.type == EType.IMAGE)
				{
					value = pageProxy.currentHitTarget.rotation;
					value -= 90;
					value = value ==-180?180:value;
					sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotation", value: value});
				}
				else if(pageProxy.currentHitTarget.type==EType.TEXT)
				{
					value = pageProxy.currentHitTarget.rotationZ;
					value -= 90;
					value = value ==-180?180:value;
					sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.MODIFY, key: "rotationZ", value: value});
				}
			}
		}
		
		protected function get pageProxy():PageProxy
		{
			return proxyMap.getProxy(PageProxy) as PageProxy;
		}
		
		override protected function onRemove():void
		{
			
		}
		
	}

}