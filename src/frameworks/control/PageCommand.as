package frameworks.control 
{
	import frameworks.message.OperateType;
	import frameworks.model.PageProxy;
	import mvcexpress.mvc.Command;
	/**
	 * ...
	 * @author yxh
	 */
	public class PageCommand extends Command
	{
		[Inject]
		public var proxy:PageProxy;
	
		public function PageCommand() 
		{
			
		}
		
		public function execute(data:Object):void 
		{
			switch(data.type)
			{
				case OperateType.ADD_PAGE:
					proxy.addPage(data);
					break;
				case OperateType.SCALE_PAGE:
					proxy.scalePage(data.value);
					break;
				case OperateType.ADD_TEXT:
					proxy.addText(data);
					break;
				case OperateType.ADD_IMAGE:
					proxy.addImage(data);
					break;
				case OperateType.ADD_MOVIE:
					proxy.addMovie(data);
					break;
				case OperateType.ADD_MUSIC:
					proxy.addMusic(data);
					break;
				case OperateType.ADD_SVG:
					proxy.addSvg(data);
					break;
				case OperateType.ADD_ANI:
					proxy.modify(data);
					break;
				case OperateType.REMOVE_PAGE:
					proxy.deletePage(data);
					break;
				case OperateType.SHOW_PAGE:
					proxy.showPage(data);
					break;
				case OperateType.MODIFY:
					proxy.modify(data);
					break
				case OperateType.MODIFY_PAGE:
					proxy.modifyPage(data);
					break;
				case OperateType.OPERATE:
					proxy.operate(data);
					break
				case OperateType.PLAY:
					proxy.play(data);
					break;
				case OperateType.PREVIEW:
					proxy.preview();
					break;
				
			}
		}
		
	}

}