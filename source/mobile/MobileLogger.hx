package mobile;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
import haxe.io.Path;
import haxe.CallStack;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;

class MobileLogger
{
	public static var logFolder:String = StorageUtil.getModsPath() + "logs/";
	public static var logFile:String = logFolder + "log_" + Date.now().getTime() + ".txt";

	public static function init():Void
	{
		#if android || sys
		if (!FileSystem.exists(logFolder))
			FileSystem.createDirectory(logFolder);

		File.saveContent(logFile, "=== Codename Engine Verbose Log ===\n");

		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(
			UncaughtErrorEvent.UNCAUGHT_ERROR,
			function(e)
			{
				log("=== UNCAUGHT ERROR ===");
				log(Std.string(e.error));
				log(CallStack.toString(CallStack.exceptionStack()));
			}
		);

		trace("MobileLogger initialized");
		#end
	}

	public static function log(text:String):Void
	{
		#if android || sys
		try
		{
			var previous:String = FileSystem.exists(logFile) ? File.getContent(logFile) : "";
			var timestamp:String = Date.now().toString();
			var msg:String = "[" + timestamp + "] " + text + "\n";
			File.saveContent(logFile, previous + msg);
			trace(msg); // also output to console
		}
		catch (e:Dynamic) {}
		#end
	}

	public static function logAsset(type:String, path:String, success:Bool):Void
		log("[ASSET] " + type + " : " + path + " => " + (success ? "LOADED" : "MISSING"));

	public static function logSound(key:String, success:Bool):Void
		log("[SOUND] : " + key + " => " + (success ? "LOADED" : "MISSING"));

	public static function logMod(name:String, status:String):Void
		log("[MOD] : " + name + " => " + status);

	public static function logCall(name:String, details:String = ""):Void
		log("[CALL] : " + name + (details != "" ? " | Details: " + details : ""));

	public static function logSong(song:String, difficulty:String, variant:String = ""):Void
		log("[SONG] : " + song + " | Difficulty: " + difficulty + " | Variant: " + variant);

	public static function close():Void
	{
		#if android || sys
		log("MobileLogger closed");
		#end
	}
}
