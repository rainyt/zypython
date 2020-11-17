package python;

@:pythonImport("pandas")
extern class Pandas {

    @:native("ExcelWriter")
    public static function writer(file:String):PandasObject;

    @:native("read_html")
    public static function readHtml(data:String):Dynamic;

}


extern class PandasObject {

    public function close():Void;

}