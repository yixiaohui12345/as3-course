/*--------------------
　XML要素を配列に変換
　2008.02.13 kUBoh
　2008.02.29 バグ修正
--------------------*/

package com.usunekoserv{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	public class XML2Array
	{
		private static var nodeIndex:int = 0;
		//こんすとらくたー
		function XML2Array()
		{
		}
		//ターゲットのノードを一番頭の要素に設定
		public static function doConvert(tgtXML:XML):Array
		{
			nodeIndex = 0;
			var document:XMLDocument = new XMLDocument(tgtXML);
			return (getNode(document.firstChild));
		}
		//ノード解析
		public static function getNode(tgtNode:XMLNode):Array
		{
			
			var tmp_Array:Array = new Array();
			//tgtNodeの存在する要素をピックアップ
			for (var tmpNode:XMLNode = tgtNode; tmpNode != null; tmpNode = tmpNode.nextSibling)
			{
				//XML上の並び順を記録
				nodeIndex++;
				//配列に要素を追加
				if (tmpNode.nodeName != null)
				{
					//エレメントノードの場合 
					if (tmp_Array[tmpNode.nodeName] == undefined)
					{
						tmp_Array[tmpNode.nodeName] = new Array();
					}
					//対象の要素は子のノードを持っているか？                                  
					if (tmpNode.hasChildNodes()==true)
					{
						tmp_Array[tmpNode.nodeName].push(getNode(tmpNode.firstChild));
					}
					else
					{
						tmp_Array[tmpNode.nodeName].push(new Array());
					}
					//tmp_Array[tmpNode.nodeName][tmp_Array[tmpNode.nodeName].length - 1]._index = nodeIndex;
					//配列に属性を追加   
					for (var att_Name in tmpNode.attributes)
					{
						var indexNum:Number = Math.max(0, tmp_Array[tmpNode.nodeName].length - 1);
						if (tmp_Array[tmpNode.nodeName][indexNum] == undefined)
						{
							tmp_Array[tmpNode.nodeName][indexNum] = new Array();
						}
						tmp_Array[tmpNode.nodeName][indexNum][att_Name] = tmpNode.attributes[att_Name];
					}
				}
				else
				{
					//テキストノードの場合 
					tmp_Array._value = tmpNode.nodeValue;
				}
			}
			return (tmp_Array);
		}
	}
	
}
