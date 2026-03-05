package mobile;

#if android
import extension.androidtools.os.Build.VERSION as AndroidVersion;
import extension.androidtools.os.Build.VERSION_CODES as AndroidVersionCode;
import extension.androidtools.Permissions as AndroidPermissions;
import extension.androidtools.Environment as AndroidEnvironment;
import extension.androidtools.Settings as AndroidSettings;
import lime.system.System;
import sys.FileSystem;
import mobile.NativeAPI;
#end

class StorageUtil
{
	#if android
	public static function requestPermissions():Void
	{
		if (AndroidVersion.SDK_INT >= AndroidVersionCode.TIRAMISU) {
			AndroidPermissions.requestPermissions([
				"READ_MEDIA_IMAGES",
				"READ_MEDIA_VIDEO",
				"READ_MEDIA_AUDIO",
				"READ_MEDIA_VISUAL_USER_SELECTED"
			]);
		} else {
			AndroidPermissions.requestPermissions([
				"READ_EXTERNAL_STORAGE",
				"WRITE_EXTERNAL_STORAGE"
			]);
		}

		if (!AndroidEnvironment.isExternalStorageManager()) {
			AndroidSettings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
		}

		var granted = AndroidPermissions.getGrantedPermissions();
		var missingPermissions = [];

		if (AndroidVersion.SDK_INT >= AndroidVersionCode.TIRAMISU) {
			if (!granted.contains("android.permission.READ_MEDIA_IMAGES"))
				missingPermissions.push("READ_MEDIA_IMAGES");
		} else {
			if (!granted.contains("android.permission.READ_EXTERNAL_STORAGE"))
				missingPermissions.push("READ_EXTERNAL_STORAGE");
		}

		if (missingPermissions.length > 0) {
			NativeAPI.showMessageBox(
				"Notice!",
				"If you accepted the permissions you are all good!\n" +
				"If you didn't then expect a crash\n" +
				"Missing: " + missingPermissions.join(", ") +
				"\nPress OK to see what happens"
			);
		}

		try {
			var dir = StorageUtil.getStorageDirectory();
			if (!FileSystem.exists(dir))
				FileSystem.createDirectory(dir);
		} catch (e:Dynamic) {
			NativeAPI.showMessageBox(
				"Error!",
				"Please create directory manually:\n" + StorageUtil.getStorageDirectory() +
				"\nPress OK to close the game"
			);
			System.exit(1);
		}
	}

	public static function getStorageDirectory():String {
		return "/storage/emulated/0/.CodenameEngine-v1.0.1/";
	}
	#end
}
