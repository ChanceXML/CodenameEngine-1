package mobile;

#if android
import extension.androidtools.os.Build.VERSION as AndroidVersion;
import extension.androidtools.os.Build.VERSION_CODES as AndroidVersionCode;
import extension.androidtools.Permissions as AndroidPermissions;
#end

class StorageUtil
{
	#if android
	public static function requestPermissions():Void
	{
		if (AndroidVersion.SDK_INT >= AndroidVersionCode.TIRAMISU)
		{
			AndroidPermissions.requestPermissions([
				"android.permission.READ_MEDIA_IMAGES",
				"android.permission.READ_MEDIA_VIDEO",
				"android.permission.READ_MEDIA_AUDIO"
			]);
		}
		else
		{
			AndroidPermissions.requestPermissions([
				"android.permission.READ_EXTERNAL_STORAGE",
				"android.permission.WRITE_EXTERNAL_STORAGE"
			]);
		}
	}
	#end
}
