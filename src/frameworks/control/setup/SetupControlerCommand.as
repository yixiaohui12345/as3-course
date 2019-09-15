package frameworks.control.setup
{
	import frameworks.control.CourseCommand;
	import frameworks.control.LoginCommand;
	import frameworks.control.MovieCommand;
	import frameworks.control.PageCommand;
	import frameworks.control.PictureCommand;
	import frameworks.control.UserInfoCommand;
	import frameworks.message.ViewMsg;
	import mvcexpress.mvc.Command;
	
	/**
	 * Initial set up of maping commands to messages.
	 * commandMap.map(type:String, commandClass:Class);
	 * @author
	 */
	public class SetupControlerCommand extends Command
	{
		
		public function execute(blank:Object):void
		{
			commandMap.map(ViewMsg.OPERATE_PAGE, PageCommand);
			commandMap.map(ViewMsg.SEND_BOOK, PictureCommand);
			commandMap.map(ViewMsg.SEND_MOVIE, MovieCommand);
			commandMap.map(ViewMsg.OPERATE_COURSE, CourseCommand);
			commandMap.map(ViewMsg.SEND_LOGIN, LoginCommand);
			commandMap.map(ViewMsg.SEND_USERINFO, UserInfoCommand);
		}
	}
}