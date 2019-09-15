package frameworks.model 
{
	import com.maccherone.json.JSON;
	import flash.net.URLVariables;
	/**
	 * ...
	 * @author yxh
	 */
	public class ActionData 
	{
		private static var jsonStr:String = null;
		
		public function ActionData() 
		{
			
		}
		
		/**
		 * 
		 * @param	bookId
		 * @param	userId
		 * @param	roleId
		 * @return
		 */
		public static function getBookList(bookId:int,userId:int,roleId:int):URLVariables
		{
			var obj:Object = { };
			obj.id = bookId;
			obj.userId = userId;
			obj.roleId = roleId;
			
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["requestContent"] = jsonStr;
			obj = null;
			return variables
		
		}
		
		public static function getBookTypeLib(btypeid:String,bookType:String, pagenow:int = 1):URLVariables
		{
			var obj:Object = { };
			var lib:Object = (btypeid == null)?null: {id:btypeid};
			var type:Object = (bookType == null)?null:{id:bookType};
			obj.BookLib=lib
			obj.BookType = type;
			obj.pagenow = pagenow;
			obj.count=27
			
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			trace(jsonStr);
			variables["strObject"] = jsonStr;
			variables["strmd5"] = "md5";
			obj = null;
			lib = null;
			type = null;
			return variables
		}
		
		public static function selectMaterialPricture(btypeid:int, booklib:int, pixel:String="2072*1256", picType:String="J"):URLVariables
		{
			var obj:Object = { };
			var MaterialPricture:Object = {}
			MaterialPricture.booktypeId = btypeid;
			MaterialPricture.booklibId = booklib;
			MaterialPricture.pricturePixel = pixel;
			MaterialPricture.pictureApplicabilityDownloadType = picType;
			obj.MaterialPricture = MaterialPricture
			
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["strObject"] = jsonStr;
			variables["strmd5"] = "md5";
			obj = null;
			MaterialPricture = null;
			return variables;
		}
		
		/**
		 * 
		 * @param	userId
		 * @param	title
		 * @param	description
		 * @param	tag
		 * @param	pageCount
		 * @param	limitA
		 * @param	fileContent
		 * @return
		 */
		public static function uploadCourseFile(userId:int,title:String,description:String,tag:String,pageCount:int,limitA:int,fileContent:String,creator:String):URLVariables
		{
			var obj:Object = { };
			var courseFile:Object = {};
			courseFile.userId = userId;
			courseFile.title = title;
			courseFile.description = description;
			courseFile.tag = tag;
			courseFile.pageCount = pageCount;
			courseFile.limitA = limitA;
			courseFile.fileContent = fileContent;
			courseFile.creator = creator;
			obj.CourseFile = courseFile;
			
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["strObject"] = jsonStr;
			variables["strmd5"] = "md5";
			obj = null;
			courseFile = null;
			return variables;
		}
		
		public static function deleteCourseFile(userId:String,idS:String):URLVariables
		{
			var obj:Object = { };
			var courseFile:Object = {};
			courseFile.idS = idS;
			courseFile.userId = userId;
			obj.CourseFile = courseFile;
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["strObject"] = jsonStr;
			variables["strmd5"] = "md5";
			obj = null;
			return variables;
		}
		
		/**
		 * 
		 * @param	id
		 * @param	tag
		 * @param	limitA
		 * @param	pagenow
		 * @param	count
		 */
		public static function selectCourseFile(id:String = null, tag:String = null, limitA:String = null,title:String=null, pagenow:int = 1, count:int =9):URLVariables
		{
			var obj:Object = { };
			var courseFile:Object = {};
			id ? courseFile.userId = id:null;
			tag? courseFile.tag = tag:null;
			limitA ? courseFile.limitA = limitA:null;
			title?courseFile.title = title:null;
			obj.CourseFile = courseFile;
			obj.pagenow = pagenow;
			obj.count = count;
			
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["strObject"] = jsonStr;
			variables["strmd5"] = "md5";
			obj = null;
			courseFile = null;
			return variables;
		}
		
		public static function downloadCourseFile(id:String):URLVariables
		{
			var obj:Object = { };
			var courseFile:Object = {};
			courseFile.id = id
			obj.CourseFile = courseFile;
			obj.pagenow = 0;
			obj.count = 0;
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["strObject"] = jsonStr;
			variables["strmd5"] = "md5";
			obj = null;
			courseFile = null;
			return variables;
		}
		
		/**
		 * 
		 * @param	userno
		 * @param	password
		 * @return
		 */
		public static function getLogin(userno:String, password:String):URLVariables
		{
			var obj:Object = { };
			obj.userno = userno;
			obj.password = password;
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["requestContent"] = jsonStr;
			obj = null;
			return variables;
		}
		
		/**
		 * 
		 * @param	userId
		 * @return
		 */
		public static function getUserInfo(userId:int):URLVariables
		{
			var obj:Object = { };
			obj.userId = userId;
			jsonStr = com.maccherone.json.JSON.encode(obj);
			var variables:URLVariables = new URLVariables();
			variables["requestContent"] = jsonStr;
			obj = null;
			return variables;
		}
	}

}