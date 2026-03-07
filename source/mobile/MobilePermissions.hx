package mobile;

#if android
import extension.androidtools.os.Build.VERSION as AndroidVersion;
import extension.androidtools.os.Build.VERSION_CODES as AndroidVersionCode;
import extension.androidtools.Permissions as AndroidPermissions;
import extension.androidtools.Environment as AndroidEnvironment;
import extension.androidtools.Settings as AndroidSettings;
#end

class StorageUtil
{
	#if android
	public static function requestPermissions():Void
	{
		if (AndroidVersion.SDK_INT >= AndroidVersionCode.TIRAMISU)
		{
			AndroidPermissions.requestPermissions([
				"READ_MEDIA_IMAGES",
				"READ_MEDIA_VIDEO",
				"READ_MEDIA_AUDIO"
			]);
		}
		else
		{
			AndroidPermissions.requestPermissions([
				"READ_EXTERNAL_STORAGE",
				"WRITE_EXTERNAL_STORAGE"
			]);
		}

		if (!AndroidEnvironment.isExternalStorageManager())
		{
			AndroidSettings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
		}
	}
	#end
}
