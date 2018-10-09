package python;

@:pythonImport("getpass")
extern class GetPass {

    @:native("getuser")
    public static function getUserName():String;

}