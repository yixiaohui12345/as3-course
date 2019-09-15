package frameworks.view.design
{
	import flash.display.DisplayObject;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import frameworks.events.CompEvent;
	import frameworks.message.DataMsg;
	import frameworks.message.EffectConfig;
	import frameworks.message.OperateType;
	import frameworks.message.ViewMsg;
	import frameworks.model.PageConfig;
	import frameworks.model.PageProxy;
	import frameworks.model.command.CommandManager;
	import frameworks.model.vo.PageVO;
	import frameworks.view.animate.AnimationWidget;
	import frameworks.view.course.CourseNative;
	import frameworks.view.model.ModelPanel;
	import frameworks.view.movie.VideoNav;
	import frameworks.view.picture.PictureNav
	import frameworks.view.music.*;
	import frameworks.view.preview.*;
	import frameworks.view.settings.*;
	import frameworks.view.style.*;
	import frameworks.view.upload.UploadDialog;
	import frameworks.view.widget.Alert;
	import frameworks.view.widget.FontWidget;
	import morn.core.components.law.EComponent;
	import morn.core.components.law.EPage;
	import morn.core.components.law.EType;
	import morn.core.events.UIEvent;
	import mvcexpress.mvc.Mediator;
	
	/**
	 * ...
	 * @author yxh
	 */
	public class DesignMediator extends Mediator
	{
		[Inject]
		public var view:Design;
		
		public var pictureNav:PictureNav = null;
		
		public var videoNav:VideoNav = null;
		
		public var animatePanel:AnimationWidget = null;
		
		public var stylePanel:StylePanel = null;
		
		public var musicPanel:MusicPanel = null;
		
		public var settingPanel:SettingPanel = null;
		
		public var modelPanel:ModelPanel
		
		public var preview:Preview
		
		public var upload:UploadDialog
		
		public var fontWidget:FontWidget = null;
		
		public var course:CourseNative = null;
		
		public function DesignMediator()
		{
		}
		
		override protected function onRegister():void
		{
			//工具栏
			addListener(view.menu.btn_image, MouseEvent.CLICK, handleImage);
			addListener(view.menu.btn_movie, MouseEvent.CLICK, handleVideo);
			addListener(view.menu.btn_animate, MouseEvent.CLICK, handleAnimate);
			addListener(view.menu.btn_style, MouseEvent.CLICK, handleStyle);
			addListener(view.menu.btn_music, MouseEvent.CLICK, handleMusic);
			addListener(view.menu.btn_setting, MouseEvent.CLICK, handleSetting);
			addListener(view.menu.btn_model, MouseEvent.CLICK, handlerModel);
			
			//加载事件
			addListener(view.menu, CompEvent.LOAD_TXT, handleCreateText);
			//菜单栏
			addListener(view.topBar.btn_undo, MouseEvent.CLICK, undo);
			addListener(view.topBar.btn_redo, MouseEvent.CLICK, redo);
			addListener(view.topBar.btn_preview, MouseEvent.CLICK, handlePreview);
			addListener(view.topBar.btn_upload, MouseEvent.CLICK, handleUploadPage);
			addListener(view.topBar.box_exchange, MouseEvent.CLICK, handleChangeAccount);
			addListener(view.topBar.c_full, Event.CHANGE, handleFullScreen);
			addListener(view.topBar.combobox_mode, Event.CHANGE, handleCourse);
			//ppt列表
			addListener(view.pptList, CompEvent.DELETE_PAGE, handleDeletePage);
			addListener(view.pptList.btn_add, MouseEvent.CLICK, handleCreatePage);
			addListener(view.pptList, CompEvent.SHOW_PAGE, handleShowPage);
			
			view.canvas.addEventListener(CompEvent.CHANGE_SCALE, handleScalePage);
			view.topBar.addEventListener(CompEvent.CHANGE_SCALE, handleScalePage);
			
			addHandler(DataMsg.RESPONSE_UPDATE_SLIDE, updateSlideBroadcast);
			addHandler(DataMsg.RESPONSE_ADD_PAGE, addPageBroadcast);
			addHandler(DataMsg.RESPONSE_ADD_ITEM, addItemBroadcast);
			addHandler(DataMsg.SELECT_ITEM, selectItemBroadcast);
			addHandler(DataMsg.RESPONSE_PREVIEW, showPreviewBroadcast);
			addHandler(DataMsg.UPDATE_CURRENT_PAGE, updateCurrentPageBroadcast);
		}
		
		private function updateCurrentPageBroadcast(data:Object):void 
		{
			view.canvas.updatePage(data);
		}
		
		private function updateSlideBroadcast(bitmapArr:Array):void
		{
			view.topBar.label_percent.text = pageProxy.scale * 100 + "%";
			view.pptList.updateVO(pageProxy.vector,pageProxy.currentPageIndex,bitmapArr);
		}
		
		private function selectItemBroadcast(data:Object):void
		{
			if (data && data is EComponent)
			{
				switch(data.type)
				{
					case EType.TEXT:
						fontWidget = fontWidget || new FontWidget();
						fontWidget.x = (view.width-fontWidget.width)*0.5
						fontWidget.y = 40;
						view.addChild(fontWidget);
						fontWidget.update(data);
						fontWidget.btn_close.addEventListener(MouseEvent.CLICK, hideFontWidget);
						fontWidget.addEventListener(CompEvent.CHANGE_PROPERTY, fontPropertyChange);
						break
				}
				if (stylePanel && stylePanel.parent)
				{
					stylePanel.onUpdate((data as EComponent),pageProxy.pageCount)
				}
			}
		}
		
		private function addPageBroadcast(vo:PageVO):void 
		{
			view.canvas.addPage(vo);
		}
		
		private function addItemBroadcast(data:Object):void
		{
			if (data.item)
			{
				switch(data.item.type)
				{
					case EType.TEXT:
						fontWidget = fontWidget || new FontWidget();
						fontWidget.x = (view.width-fontWidget.width)*0.5
						fontWidget.y = 40;
						view.addChild(fontWidget);
						fontWidget.update(data);
						fontWidget.btn_close.addEventListener(MouseEvent.CLICK, hideFontWidget);
						fontWidget.addEventListener(CompEvent.CHANGE_PROPERTY, fontPropertyChange);
						break;
				}
			}
		}
		
		private function showPreviewBroadcast(data:Object):void
		{
			preview = preview || new Preview();
			view.addChild(preview);
			preview.resize();
			preview.update(data as Vector.<EPage>);
		}
		
		private function onCourseRemoveEvent(e:UIEvent):void 
		{
			course && course.removeEventListener(UIEvent.REMOVE, onCourseRemoveEvent);
			view.topBar.combobox_mode.selectedIndex = 0;
		}
		
		private function handleCourse(e:Event):void 
		{
			switch(view.topBar.combobox_mode.selectedIndex)
			{
				case 0:
					break;
				case 1:
					course = course || new CourseNative();
					if (!mediatorMap.isMediated(course))
					{
						mediatorMap.mediate(course);
					}
					view.addChild(course);
					course.onUpdate();
					course.addEventListener(UIEvent.REMOVE, onCourseRemoveEvent,false,0,true);
					break;
			}
		}
		
		private function handleFullScreen(e:Event):void 
		{
			if (view.topBar.c_full.selected){
				App.stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else{
				App.stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		private function hideFontWidget(e:MouseEvent):void 
		{
			fontWidget.remove();
		}
		
		private function handleChangeAccount(e:MouseEvent):void 
		{
			dispose();
			view.dispatchEvent(new CompEvent(CompEvent.CHANGE_ACCOUNT));
		}
		
		private function handleUploadPage(e:MouseEvent):void 
		{
			upload = upload || new UploadDialog();
			if (!mediatorMap.isMediated(upload))
			{
				mediatorMap.mediate(upload);
				view.addChild(upload);
			}
			else{
				if (!upload.parent){
					view.addChild(upload);
				}
			}
			
		}
		
		private function handleShowPage(e:CompEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.SHOW_PAGE, index:e.data.index});
		}
		
		private function handleDeletePage(e:CompEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.REMOVE_PAGE, index:e.data.index,target:e.data.target});
		}
		
		private function handleCreatePage(e:MouseEvent):void 
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.ADD_PAGE});
		}
		
		private function handlePreview(e:MouseEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.PREVIEW});
		}
		
		private function handlerModel(e:MouseEvent):void{
			pictureNav && pictureNav.remove();
			videoNav && videoNav.remove();
			animatePanel && animatePanel.remove();
			stylePanel && stylePanel.remove();
			musicPanel && musicPanel.remove();
			settingPanel && settingPanel.remove();
			modelPanel = modelPanel || new ModelPanel();
			modelPanel.resize();
			if (!mediatorMap.isMediated(modelPanel))
			{
				mediatorMap.mediate(modelPanel);
				view.addChild(modelPanel);
			}
			else{
				if (modelPanel.parent){
					modelPanel.remove();
				}else{
					view.addChild(modelPanel);
				}
			}
		}
		
		private function handleSetting(e:MouseEvent):void 
		{
			modelPanel && modelPanel.remove();
			pictureNav && pictureNav.remove();
			videoNav && videoNav.remove();
			animatePanel && animatePanel.remove();
			stylePanel && stylePanel.remove();
			musicPanel && musicPanel.remove();
			settingPanel = settingPanel || new SettingPanel();
			settingPanel.resize();
			if (!mediatorMap.isMediated(settingPanel))
			{
				mediatorMap.mediate(settingPanel);
				view.addChild(settingPanel);
			}else{
				if (settingPanel.parent){
					settingPanel.remove();
				}else{
					view.addChild(settingPanel);
				}
			}
		}
		
		private function handleMusic(e:MouseEvent):void 
		{
			modelPanel && modelPanel.remove();
			pictureNav && pictureNav.remove();
			videoNav && videoNav.remove();
			animatePanel && animatePanel.remove();
			stylePanel && stylePanel.remove();
			settingPanel && settingPanel.remove();
			musicPanel = musicPanel || new MusicPanel();
			if (!mediatorMap.isMediated(musicPanel)){
				mediatorMap.mediate(musicPanel);
				view.addChild(musicPanel);
			}
			else{
				if (musicPanel.parent){
					musicPanel.remove();
				}else{
					view.addChild(musicPanel);
				}
			}
		}
		
		private function handleStyle(e:MouseEvent=null):void
		{
			modelPanel && modelPanel.remove();
			pictureNav && pictureNav.remove();
			videoNav && videoNav.remove();
			animatePanel && animatePanel.remove();
			musicPanel && musicPanel.remove();
			settingPanel && settingPanel.remove();
			stylePanel = stylePanel || new StylePanel();
			stylePanel.onUpdate(pageProxy.currentHitTarget as EComponent, pageProxy.pageCount);
			if (!mediatorMap.isMediated(stylePanel)){
				mediatorMap.mediate(stylePanel);
				view.addChild(stylePanel);
			}
			else{
				if (stylePanel.parent){
					stylePanel.remove();
				}else{
					view.addChild(stylePanel);
				}
			}
		}
		
		private function handleAnimate(e:MouseEvent):void
		{
			modelPanel && modelPanel.remove();
			pictureNav && pictureNav.remove();
			videoNav && videoNav.remove();
			stylePanel && stylePanel.remove();
			musicPanel && musicPanel.remove();
			settingPanel && settingPanel.remove();
			animatePanel = animatePanel || new AnimationWidget();
			if (!mediatorMap.isMediated(animatePanel)){
				mediatorMap.mediate(animatePanel);
				view.addChild(animatePanel);
			}
			else{
				if (animatePanel.parent){
					animatePanel.remove();
				}
				else{
					view.addChild(animatePanel);
				}
			}
		}
		
		private function handleVideo(e:MouseEvent):void
		{
			modelPanel && modelPanel.remove();
			pictureNav && pictureNav.remove();
			animatePanel && animatePanel.remove();
			settingPanel && settingPanel.remove();
			stylePanel && stylePanel.remove();
			musicPanel && musicPanel.remove();
			videoNav = videoNav || new VideoNav();
			if (!mediatorMap.isMediated(videoNav)){
				mediatorMap.mediate(videoNav);
				view.addChild(videoNav);
			}
			else{
				if (videoNav.parent){
					videoNav.remove();
				}
				else{
					view.addChild(videoNav);
				}
			}
		}
		
		private function handleImage(e:MouseEvent):void
		{
			modelPanel && modelPanel.remove();
			videoNav && videoNav.remove();
			animatePanel && animatePanel.remove();
			settingPanel && settingPanel.remove();
			stylePanel && stylePanel.remove();
			musicPanel && musicPanel.remove();
			pictureNav = pictureNav || new PictureNav();
			if (!mediatorMap.isMediated(pictureNav)){
				mediatorMap.mediate(pictureNav);
				view.addChild(pictureNav);
			}
			else{
				if (pictureNav.parent){
					pictureNav.remove();
				}
				else{
					view.addChild(pictureNav);
				}
			}
		}
		
		private function handleScalePage(e:CompEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.SCALE_PAGE, value: e.data});
			view.topBar.label_percent.text = Number(Number(e.data) * 100).toFixed(0) + "%";
			view.topBar.slider.value = Number(e.data);
			view.canvas.resizePage();
		}
		
		private function handleCreateText(e:CompEvent):void
		{
			if (e.data.target && pageProxy.currentPage && (e.data.target as DisplayObject).hitTestObject(pageProxy.currentPage as DisplayObject))
			{
				var p:Point = pageProxy.currentPage.globalToLocal(new Point(e.data.px, e.data.py))
				var px:Number = p?p.x:0;
				var py:Number = p?p.y:0;
				sendMessage(ViewMsg.OPERATE_PAGE, {type: OperateType.ADD_TEXT, x:px, y:py});
			}
		}
		
		private function fontPropertyChange(e:CompEvent):void
		{
			sendMessage(ViewMsg.OPERATE_PAGE, {type:OperateType.MODIFY, key:e.data.key, value:e.data.value});
		}
		
		protected function get pageProxy():PageProxy
		{
			return proxyMap.getProxy(PageProxy) as PageProxy;
		}
		
		private function redo(e:MouseEvent):void
		{
			CommandManager.inst.Redo();
		}
		
		private function undo(e:MouseEvent):void
		{
			CommandManager.inst.Undo();
		}
		
		private function dispose():void{
			if (pageProxy){
				pageProxy.dispose();
			}
			view.pptList.dispose();
		}
		
		override protected function onRemove():void
		{
		
		}
	}

}