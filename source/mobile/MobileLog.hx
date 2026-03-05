package funkin.mobile;

import sys.io.File;
import sys.FileSystem;
import haxe.CallStack;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;

class DebugLogger
{
    static var basePath:String = "/storage/emulated/0/.CodenameEngine-v1.0.1/logs/";
    static var filePath:String = basePath + "log.txt";

    public static function init()
    {
        #if android
        try
        {
            if (!FileSystem.exists(basePath))
                FileSystem.createDirectory(basePath);

            File.saveContent(filePath, "=== Codename Engine Android Log ===\n");

            Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(
                UncaughtErrorEvent.UNCAUGHT_ERROR,
                function(e)
                {
                    log("=== UNCAUGHT CRASH ===");
                    log(Std.string(e.error));
                    log(CallStack.toString(CallStack.exceptionStack()));
                }
            );

            log("DebugLogger initialized.");
        }
        catch (e:Dynamic) {}
        #end
    }

    public static function log(text:String)
    {
        #if android
        try
        {
            var previous = FileSystem.exists(filePath) ? File.getContent(filePath) : "";
            var timestamp = Date.now().toString();
            File.saveContent(filePath, previous + "[" + timestamp + "] " + text + "\n");
        }
        catch (e:Dynamic) {}
        #end
    }

    public static function logAsset(type:String, path:String, success:Bool)
    {
        log("[ASSET] " + type + " : " + path + " => " + (success ? "LOADED" : "MISSING"));
    }

    public static function logSound(key:String, success:Bool)
    {
        log("[SOUND] : " + key + " => " + (success ? "LOADED" : "MISSING"));
    }

    public static function logMod(name:String, status:String)
    {
        log("[MOD] : " + name + " => " + status);
    }

    public static function logSong(song:String, difficulty:String, variant:String = "")
    {
        log("[SONG] : " + song + " | Difficulty: " + difficulty + " | Variant: " + variant);
    }

    public static function logCall(name:String, details:String = "")
    {
        log("[CALL] : " + name + (details != "" ? " | Details: " + details : ""));
    }

    public static function close()
    {
        #if android
        log("DebugLogger closed.");
        #end
    }
}
