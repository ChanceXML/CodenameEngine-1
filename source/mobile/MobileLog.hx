package mobile;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
import haxe.Log;
import haxe.PosInfos;
import haxe.io.Path;

class MobileLog {
    public static var logFolder:String;
    public static var logFile:String;

    public static function init():Void {
        #if (mobile && sys)
        logFolder = "/storage/emulated/0/.CodenameEngine-v1.0.1/logs/";
        if (!FileSystem.exists(logFolder)) FileSystem.createDirectory(logFolder);

        logFile = logFolder + "log_" + Date.now().getTime() + ".txt";

        Log.trace = function(v:Dynamic, pos:PosInfos):Void {
            var msg = Date.now().toString() + " : " + Std.string(v);
            try {
                File.append(logFile, msg + "\n");
            } catch(e:Dynamic) {
            }
            haxe.Log.print(msg, pos);
        }

        Log.trace("=== MobileLog Initialized ===");
        #end
    }

    public static function logAsset(type:String, path:String, success:Bool):Void {
        Log.trace("[ASSET] " + type + " : " + path + " => " + (success ? "LOADED" : "MISSING"));
    }

    public static function logSound(type:String, key:String, success:Bool):Void {
        Log.trace("[SOUND] " + type + " : " + key + " => " + (success ? "LOADED" : "MISSING"));
    }

    public static function logMod(name:String, status:String):Void {
        Log.trace("[MOD] " + name + " => " + status);
    }

    public static function logCall(name:String, details:String = ""):Void {
        Log.trace("[CALL] " + name + (details != "" ? " : " + details : ""));
    }
}
