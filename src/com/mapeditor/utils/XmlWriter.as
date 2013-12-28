/* 
	Eb163 Flash RPG Webgame Framework
	@author eb163.com
	@email game@eb163.com
	@website www.eb163.com
 */
package com.mapeditor.utils
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	public class XmlWriter extends EventDispatcher
	{
        private var _urlStr:String;
        private var _xml:XML;
		private var _byteArr:ByteArray;
		//xml
		private var _fileXml:File;
		private var _fileStreamXml:FileStream;
		
		public function XmlWriter(tgareXml:XML,xmlName:String)
		{
            _urlStr = File.applicationDirectory.nativePath  +  "/../resource/data/maps/";
            _xml = tgareXml;
            _urlStr = _urlStr.replace(/\\/g, "/");
		
			_fileXml = new File();
			xmlName = "mapconfig" + xmlName;
			_fileXml = _fileXml.resolvePath(_urlStr + xmlName +".xml");
			_fileStreamXml = new FileStream();
            return;
		}
		
		 public function writeFun() : void
        {
			_fileStreamXml.openAsync(_fileXml, FileMode.WRITE);
			_fileStreamXml.writeUTFBytes(_xml);
//			_fileStreamXml.close()
            Alert.show("地图文件写入成功！\n保存路径：" + _fileXml.nativePath);
        }
	}
}