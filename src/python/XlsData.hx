package python;

import sys.FileSystem;
import python.Chardet;
import haxe.io.Encoding;
import sys.io.File;
import python.Pandas;

@:pythonImport("xlwt")
extern class WriteXlsData{

    /**
     * 创建一个工作表
     * @return XlsData
     */
    @:native("Workbook")
    public static function create(a:Dynamic,b:Dynamic):WriteXlsData;

    /**
     * 添加一个表
     * @param name 
     */
    @:native("add_sheet")
    public function addSheet(name:String):WriteXlsSheet;

    /**
     * 储存
     * @param name 
     * @return XlsData
     */
    public function save(path:String):Void;

}

extern class WriteXlsSheet {
    
    /**
     * 写入到表
     * @param c 
     * @param r 
     * @param value 
     */
    public function write(c:Int,r:Int,value:Dynamic):Void;
}

@:pythonImport("xlrd")
extern class XlsData implements Xls {

    /**
     * 打开xls数据表
     * @param path 
     * @return XlsData
     */
    @:native("open_workbook")
    public static function open(path:String):XlsData;

    /**
     * 获取Sheets名字列表
     * @return Array<String>
     */
    @:native("sheet_names")
    public function getSheetsNames():Array<String>;

    /**
     * 获取表
     * @param name 
     * @return XlsSheet
     */
    @:native("sheet_by_name")
    public function getSheet(name:String):XlsSheet;

}

/**
 * 表数据
 */
extern class XlsSheet implements Sheet {

    /**
     * 总行数
     */
    public var nrows:Int;

    /**
     * 总列数
     */
    public var ncols:Int;

     /**
     * 获取列值
     * @param index 
     * @return Array<String>
     */
    @:native("col_values")
    public function getColValues(index:Int):Array<String>;

    /**
     * 获取行值
     * @param index 
     * @return Array<String>
     */
    @:native("row_values")
    public function getRowValues(index:Int):Array<String>;
    
}

interface Xls {

    /**
     * 获取Sheets名字列表
     * @return Array<String>
     */
    @:native("sheet_names")
    public function getSheetsNames():Array<String>;

    /**
     * 获取表
     * @param name 
     * @return XlsSheet
     */
    @:native("sheet_by_name")
    public function getSheet(name:String):Sheet;

}

interface Sheet {
    
    /**
     * 总行数
     */
    public var nrows:Int;

    /**
     * 总列数
     */
    public var ncols:Int;

    /**
     * 获取列值
     * @param index 
     * @return Array<String>
     */
    @:native("col_values")
    public function getColValues(index:Int):Array<String>;

    /**
     * 获取行值
     * @param index 
     * @return Array<String>
     */
    @:native("row_values")
    public function getRowValues(index:Int):Array<String>;


}

class HTMLXlsData implements Xls {

    private var xls:XlsData;

    public function new(path:String){
        var data:String = null;
        var codebytes:Dynamic = null;
        Syntax.code("f2 = open(path, 'rb') ;codebytes=f2.read();f2.close();");
        var char:python.Chardet.ChardetResult = Chardet.getEncodeing(codebytes);
        var encoding:String = Syntax.code("char['encoding']");
        trace("编码：", encoding);
        Syntax.code("f = open(path, 'r', encoding=encoding);data=f.read();f.close();");
        var obj:Dynamic = Pandas.readHtml(data);
        var outpath:String = path.substr(0,path.lastIndexOf("/")) + "/txtmp";
        if(FileSystem.exists(outpath))
            FileUtils.removeDic(outpath);
        FileSystem.createDirectory(outpath);
        outpath +=  "/tmp.xls";
        var xlsWrite:PandasObject = Pandas.writer(outpath);
        obj[0].to_excel(xlsWrite);
        xlsWrite.close(); 
        trace("导出："+outpath);
        xls = XlsData.open(outpath);
    }

     @:native("sheet_names")
    public function getSheetsNames():Array<String>
    {
        return xls.getSheetsNames();
    }

    @:native("sheet_by_name")
    public function getSheet(name:String):CSVXlsSheet
    {
        return cast xls.getSheet(name);
    }

}


class CSVXlsData implements Xls {

    private var csv:CSVXlsSheet;
    
    public function new(path:String) {
        var data:String = null;
        var codebytes:Dynamic = null;
        Syntax.code("f2 = open(path, 'rb') ;codebytes=f2.read();f2.close();");
        var char:python.Chardet.ChardetResult = Chardet.getEncodeing(codebytes);
        var encoding:String = Syntax.code("char['encoding']");
        trace("编码：", encoding);
        if(encoding.toUpperCase() == "GB2312")
            encoding = "gbk";
        Syntax.code("f = open(path, 'r', encoding=encoding);data=f.read();f.close();");
        data = StringTools.replace(data,"\"","");
        csv = new CSVXlsSheet(data);
    }

    @:native("sheet_names")
    public function getSheetsNames():Array<String>
    {
        return ["default"];
    }

    @:native("sheet_by_name")
    public function getSheet(name:String):CSVXlsSheet
    {
        return csv;
    }

}

class CSVXlsSheet  implements Sheet {

    private var rarray:Array<Array<String>> = [];
    private var carray:Array<Array<String>> = [];
    
    public function new(data:String) {
        var r = data.split("\n");
        nrows = r.length;
        for (i in 0...r.length) {
            var d = r[i];
            if(d.indexOf(",") == -1)
            {
                //空格解析
                rarray[i] = d.split(String.fromCharCode(9));
            }
            else
                rarray[i] = d.split(",");
        }
        ncols = rarray[0].length;
        trace("CSV:",nrows,ncols);
    }

     /**
     * 总行数
     */
    public var nrows:Int;

    /**
     * 总列数
     */
    public var ncols:Int;

    /**
     * 获取列值
     * @param index 
     * @return Array<String>
     */
    @:native("col_values")
    public function getColValues(index:Int):Array<String>
    {
        return null;
    }

    /**
     * 获取行值
     * @param index 
     * @return Array<String>
     */
    @:native("row_values")
    public function getRowValues(index:Int):Array<String>
    {
        return rarray[index];
    }

}