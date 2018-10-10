package python;

import python.BaseFtp;

class Ftp extends BaseFtp{

    /**
     * 上传文件
     * @param path 本地上传路径
     * @param save 远程保存路径
     * @param saveName 储存名字，如果为空时，则使用本地名称
     */
    public function uploadText(path:String,save:String,saveName:String = null):Void
    {
        if(saveName == null)
            saveName = path.substr(path.lastIndexOf("/") + 1);
        setCurrentDir(save);
        var f:Dynamic = untyped open(path,"rb");
        super.uploadContent("STOR "+saveName,f,function(data:Dynamic):Void{
            // trace(data);
        });
        f.close();
    }

    /**
     * 上传2进制文件
     * @param path 本地上传路径
     * @param save 远程路径
     * @param saveName 远程储存名称，如果为null则使用本地名称
     */
    public function uploadFile(path:String,save:String,saveName:String = null):Void
    {
        if(saveName == null)
            saveName = path.substr(path.lastIndexOf("/") + 1);
        setCurrentDir(save);
        var f:Dynamic = untyped open(path,"rb");
        super.uploadBytes("STOR "+saveName,f,8192,function(data:Dynamic):Void{
            // trace(data);
        });
        f.close();
    }


    public function downloadFile(download:String,save:String):Void
    {
        var f:Dynamic = untyped open(save,"wb");
        this.download("RETR "+download,f.write,8192);
        f.close();
    }

}