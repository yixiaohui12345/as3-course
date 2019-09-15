package frameworks.control.setup
{
	
	import frameworks.view.MainMediator
	import frameworks.view.animate.*;
	import frameworks.view.design.*;
	import frameworks.view.movie.*;
	import frameworks.view.music.*;
	import frameworks.view.picture.*;
	import frameworks.view.preview.*;
	import frameworks.view.style.*;
	import frameworks.view.settings.*
	import frameworks.view.upload.*;
	import frameworks.view.course.*;
	import frameworks.view.model.*;
	import mvcexpress.mvc.Command
	
	/**
	 * Initial set up of maping mediator class to view class.
	 * mediatorMap.map(viewClass:Class, mediatorClass:Class);
	 * @author
	 */
	public class SetupViewCommand extends Command
	{
		
		public function execute(blank:Object):void
		{
			mediatorMap.map(Main, MainMediator);
			mediatorMap.map(Design, DesignMediator);
			mediatorMap.map(PictureNav, PictureMediator);
			mediatorMap.map(VideoNav, VideoMediator);
			mediatorMap.map(Preview, PreviewMediator);
			mediatorMap.map(UploadDialog, UploadMediator);
			mediatorMap.map(AnimationWidget, AnimateMediator);
			mediatorMap.map(StylePanel, StyleMediator);
			mediatorMap.map(MusicPanel, MusicMediator);
			mediatorMap.map(SettingPanel, SettingMediator);
			mediatorMap.map(CourseNative, CourseMediator);
			mediatorMap.map(ModelPanel, ModelMediator);
		}
	
	}
}