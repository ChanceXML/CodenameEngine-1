package mobile;

#if sys
import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
#end

#if android
import lime.system.System;
#end

class StorageUtil
{
	#if sys
	public static function getStorageDirectory():String
		return #if android Path.addTrailingSlash(System.applicationStorageDirectory) #else Sys.getCwd() #end;
	#end

	#if android
	public static function getExternalStorageDirectory():String
		return "/storage/emulated/0/.CodenameEngine/";

	public static function getModsPath():String
	{
		var externalFile:String = System.applicationStorageDirectory + "external.txt";
		var externalStatus:String = #if sys FileSystem.exists(externalFile) ? File.getContent(externalFile).trim().toLowerCase() : "false" #else "false" #end;
		return externalStatus == "true" ? getExternalStorageDirectory() : getStorageDirectory();
	}
	#end
}
