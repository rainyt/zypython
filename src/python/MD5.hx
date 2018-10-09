package python;

import python.lib.os.Path;
import sys.FileSystem;
import python.MD5Hashlib;
import sys.io.File;

class MD5 {
    /**
     * 通过encode获取到的MD5值，最后通过hexdigest方法进行获取最终值
     * @param file 
     * @return Dynamic
     */
    public static function encode(file:String):String
    {
        if(!FileSystem.exists(file))
        {
            return null;
        }
        //开始计算MD5
        var md5:String = MD5Hashlib.md5();
        return md5;
    }

    
}
