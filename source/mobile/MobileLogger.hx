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
	public static var logFolder:String;
	public static var logFile:String;

	static function __init() {
		#if android || sys
		try {
			logFolder = StorageUtil.getModsPath() + "logs/";
			if (!FileSystem.exists(logFolder))
				FileSystem.createDirectory(logFolder);

			logFile = logFolder + "log_" + Date.now().getTime() + ".txt";
			File.saveContent(logFile, "=== Codename Engine Verbose Log ===\n");

			Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(
				UncaughtErrorEvent.UNCAUGHT_ERROR,
				function(e) {
					log("=== UNCAUGHT ERROR ===");
					log(Std.string(e.error));
					log(CallStack.toString(CallStack.exceptionStack()));
				}
			);

			log("MobileLogger initialized");
		} catch(e:Dynamic) {}
		#end
	}

	public static function log(text:String):Void {
		#if android || sys
		try {
			if (logFile == null) return;
			var previous:String = FileSystem.exists(logFile) ? File.getContent(logFile) : "";
			var timestamp:String = Date.now().toString();
			var msg:String = "[" + timestamp + "] " + text + "\n";
			File.saveContent(logFile, previous + msg);
			trace(msg);
		} catch(e:Dynamic) {}
		#end
	}

	public static function logAsset(type:String, path:String, success:Bool):Void
		log("[ASSET] " + type + " : " + path + " => " + (success ? "LOADED" : "MISSING"));

	public static function logSound(key:String, success:Bool):Void
		log("[SOUND] : " + key + " => " + (success ? "LOADED" : "MISSING"));

	public static function logMod(name:String, status:String):Void
		log("[MOD] : " + name + " => " + status");

	public static function logCall(name:String, details:String = ""):Void
		log("[CALL] : " + name + (details != "" ? " | Details: " + details : ""));

	public static function logSong(song:String, difficulty:String, variant:String = ""):Void
		log("[SONG] : " + song + " | Difficulty: " + difficulty + " | Variant: " + variant);

	public static function close():Void
		#if android || sys
		log("MobileLogger closed");
		#end
}
