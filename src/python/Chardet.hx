package python;

@:pythonImport("chardet")
extern class Chardet {
    
    @:native("detect")
    public static function getEncodeing(text:Dynamic):ChardetResult;

}

class ChardetResult {
    
    public var encoding:String;

}