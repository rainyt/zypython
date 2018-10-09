package python;

import sys.FileSystem;
import sys.io.File;

class FileUtils {

    /**
     * 拷贝文件夹
     * @param path 
     * @param copyTo 
     */
    public static function copyDic(dic:String,copyTo:String):Void
    {
        if(!FileSystem.exists(dic)){
            trace("copyDic 路径不存在："+dic);
            return;
        }
        trace(dic + " -> " + copyTo);
        var dicName:String = dic.substr(dic.lastIndexOf("/") + 1);
        FileSystem.createDirectory(copyTo + "/" + dicName);
        var list:Array<String> = FileSystem.readDirectory(dic);
        for(file in list)
        {
            var file2:String = dic + "/" + file;
            if(FileSystem.isDirectory(file2))
            {
                copyDic(file2,copyTo + "/" + dicName);
            }
            else
            {
                File.copy(file2,copyTo + "/" + dicName);
            }
        }
    }

    /**
     * 删除文件夹
     * @param dic 
     */
    public static function removeDic(dic:String):Void
    {
        if(!FileSystem.exists(dic))
            return;
        var list:Array<String> = FileSystem.readDirectory(dic);
        for(file in list)
        {
            file = dic + "/" + file;
            if(FileSystem.isDirectory(file))
            {
                removeDic(file);
            }
            else
            {
                FileSystem.deleteFile(file);
            }
        }
        FileSystem.deleteDirectory(dic);
    }

}