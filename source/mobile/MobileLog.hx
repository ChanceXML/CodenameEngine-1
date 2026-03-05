package mobile;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
import haxe.io.Output;
import haxe.io.Path;

class MobileLog {
    public static var logFolder:String;
    public static var logFile:String;
    public static var file:Output;

    public static function init():Void {
        #if android
        logFolder = "/storage/emulated/0/.CodenameEngine-v1.0.1/logs/";
        if (!FileSystem.exists(logFolder)) FileSystem.createDirectory(logFolder);

        logFile = logFolder + "log_" + Date.now().getTime() + ".txt";
        file = sys.io.File.write(logFile, true);

        var oldTrace = trace;
        trace = function(v:Dynamic, ?pos:PosInfos):Void {
            oldTrace(v, pos);
            if (file != null) {
                file.writeString(Date.now().toString() + " : " + Std.string(v) + "\n");
                file.flush();
            }
        }

        trace("=== MobileLog Initialized ===");
        #end
    }

    public static function close():Void {
        #if android
        if (file != null) file.close();
        #end
    }

    public static function logAsset(type:String, path:String, success:Bool):Void {
        trace("[ASSET] " + type + " : " + path + " => " + (success ? "LOADED" : "MISSING"));
    }

    public static function logSound(type:String, key:String, success:Bool):Void {
        trace("[SOUND] " + type + " : " + key + " => " + (success ? "LOADED" : "MISSING"));
    }

    public static function logMod(name:String, status:String):Void {
        trace("[MOD] " + name + " => " + status);
    }
  
    public static function logCall(name:String, details:String = ""):Void {
        trace("[CALL] " + name + (details != "" ? " : " + details : ""));
    }
}
