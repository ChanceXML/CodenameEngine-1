import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;

class CopyAssets
{
    static var DEST = "/storage/emulated/0/Android/data/com.yoshman29.codenameengine/files/";

    static function main()
    {
        var folders = ["assets", "mods"];
        for (folder in folders)
        {
            var srcPath = folder;
            var destPath = DEST + folder;
            copyFolder(srcPath, destPath);
        }
        trace("Folders copied successfully!");
    }

    static function copyFolder(src:String, dest:String)
    {
        if (!FileSystem.exists(src)) return;

        if (!FileSystem.exists(dest)) FileSystem.createDirectory(dest);

        for (file in FileSystem.readDirectory(src))
        {
            var srcFile = src + "/" + file;
            var destFile = dest + "/" + file;
            if (FileSystem.isDirectory(srcFile))
            {
                copyFolder(srcFile, destFile);
            }
            else
            {
                copyFile(srcFile, destFile);
            }
        }
    }

    static function copyFile(src:String, dest:String)
    {
        var content = sys.io.File.getBytes(src);
        var out = FileOutput.write(dest, true);
        out.write(content, 0, content.length);
        out.close();
    }
}
