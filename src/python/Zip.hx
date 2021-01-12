package python;

@:pythonImport("zipfile")
extern class Zip {
    
    public static var ZIP_STORED:Dynamic;

    public static function ZipFile(zipName:String,mode:String,ob:Dynamic):Zip;

    public function write(filename:String):Void;

    public function close():Void;

}