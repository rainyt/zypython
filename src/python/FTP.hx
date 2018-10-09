package python;

@:pythonImport("ftplib","FTP")
extern class FTP {

    public function new():Void;

    public function connect(ip:String,port:Int):Void;

    @:native("set_debuglevel")
    public function debug(code:Int):Void;

    public function login(userName:String,password:String):Void;

    public function quit():Void;

    @:native("cwd")
    public function setCurrentDir(path:String):Void;
    
    @:native("nlst")
    public function getFileList():Array<String>;
}