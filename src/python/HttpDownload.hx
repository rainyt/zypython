package python;

@:pythonImport("urllib.request")
extern class HttpDownload {

    /**
     * 下载资源
     */
    @:native("urlretrieve")
    public static function download(url:String,save:String,progres:Int->Int->Int->Void = null):Dynamic;

}