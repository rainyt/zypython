package python;

import python.Tuple;

/**
 * 安装命令：pip3 install Pillow
 */
@:pythonImport("PIL","Image")
extern class Image {

    public static var ANTIALIAS:Dynamic;

    public static function open(path:String):ImageData;

    @:native("alpha_composite")
    public static function composite(img:ImageData,img2:ImageData):ImageData;

}

extern class ImageData {

    /**
     * 保存文件
     * @param path 
     */
    public function save(path:String):Void;

    /**
     * 使用本地工具打开展示
     */
    public function show():Void;

    /**
     * 尺寸大小
     */
    public var size:Tuple2<Float,Float>; 

    /**
     * 调整尺寸
     * @param width 
     * @param height 
     * @return ImageData
     */
    public function resize(size:Tuple2<Float,Float>,mode:Dynamic = null):ImageData;

}

@:pythonImport("PIL","ImageDraw")
extern class ImageDraw {

    @:native("Draw")
    public static function create(img:ImageData):ImageDraw;

    public function text(pos:Tuple2<Float,Float>,text:String,color:Tuple3<Int,Int,Int>,font:ImageFont):Void;

    @:native("bitmap")
    public function drawImage(pos:Tuple2<Float,Float>,img:ImageData,color:Tuple3<Int,Int,Int>):Void;

}

@:pythonImport("PIL","ImageFont")
extern class ImageFont {

    @:native("truetype")
    public static function create(font:String,size:Int):ImageFont;

    public function getsize(text:String):Tuple2<Float,Float>;

}