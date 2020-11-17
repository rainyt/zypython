package python;


@:pythonImport("hashlib")
extern class MD5Hashlib {

    public function new();

    @:native("md5(open(file,'rb').read()).hexdigest")
    public static function md5():String;

}