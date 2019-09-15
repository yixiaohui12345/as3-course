package org.utils 
{
	import com.hurlant.crypto.symmetric.AESKey;
	import com.hurlant.crypto.symmetric.CBCMode;
	import com.hurlant.util.Base64;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author yxh
	 */
	public class AESUtils 
	{
		
		public function AESUtils() 
		{
			
		}
		
		public static function encode(value:String, key:String="noerkey", iv:String="noeriv"):String
		{
			var bkey:ByteArray= new   ByteArray();  
			bkey.writeUTFBytes(key);  
			var biv:ByteArray= new  ByteArray();  
			biv.writeUTFBytes(iv);  
			var des:AESKey=new AESKey(bkey);  
			var cbc:CBCMode=new CBCMode(des);
			cbc.IV = biv; 
			var bytes:ByteArray=new ByteArray();    
			bytes.writeUTFBytes(value);  
			cbc.encrypt(bytes);  
			var result:String = Base64.encodeByteArray(bytes);
			return result;
		}
		
		public static function decode(value:String,key:String="noerkey", iv:String="noeriv"):String
		{
			var bytes:ByteArray = Base64.decodeToByteArray(value);
			var bkey:ByteArray= new   ByteArray();  
			bkey.writeUTFBytes(key);  
			var biv:ByteArray= new  ByteArray();  
			biv.writeUTFBytes(iv);  
			var des:AESKey = new AESKey(bkey);   
			var cbc:CBCMode = new CBCMode(des);
			cbc.IV = biv; 
			cbc.decrypt(bytes);
			var result:String = StringUtils.convertToString(bytes);
			return result;
		}
		
	}

}