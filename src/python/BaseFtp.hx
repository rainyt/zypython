package python;

@:pythonImport("ftplib","FTP")
extern class BaseFtp {

    public function new():Void;

    /**
     * 连接FTP
     * @param ip 
     * @param port 
     */
    public function connect(ip:String,port:Int):Void;

    /**
     * 设置DEBUG模式
     * @param code 
     */
    @:native("set_debuglevel")
    public function debug(code:Int):Void;

    /**
     * 登录FTP
     * @param userName 
     * @param password 
     */
    public function login(userName:String,password:String):Void;

    /**
     * 关闭当前FTP
     */
    @:native("quit")
    public function close():Void;

    /**
     * 设置当前工作路径
     * @param path 
     */
    @:native("cwd")
    public function setCurrentDir(path:String):Void;

    /**
     * 获取文件列表
     * @return Array<String>
     */
    @:native("nlst")
    public function getFileList():Array<String>;

    /**
     * 获取欢迎语
     * @return String
     */
    @:native("getwelcome")
    public function getWelcome():String;

    /**
     * 读取Filelist列表
     * @param type 
     * @param func 
     */
    @:native("retrlines")
    public function getFileListMsg(type:String = "LIST",func:Dynamic->Void = null):Void;

    /**
     * 设置是否被动，默认被动
     * @param bool 
     */
    @:native("set_pasv")
    public function setPasv(bool:Bool):Void;

    /**
     * 上传文本内容
     * @param cmd 
     * @param fp 
     * @param callback 
     */
    @:protected
    @:native("storlines")
    public function uploadContent(cmd:String,fp:Dynamic,callback:Dynamic->Void = null):Void;

    /**
     * 上传2进制文件
     * @param cmd 
     * @param fp 
     * @param blocksize 
     * @param callback 
     */
    @:property
    @:native("storbinary")
    public function uploadBytes(cmd:String,fp:Dynamic,blocksize:Int = 8192,callback:Dynamic->Void = null):Void;

    /**
     * 删除文件
     * @param path 
     * @return String
     */
    @:native("delete")
    public function deleteFile(path:String):String;

    @:native("retrbinary")
    public function download(cmd:String,callback:Dynamic,blocksize:Int = 1024):Void;

}