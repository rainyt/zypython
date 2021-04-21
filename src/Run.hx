import haxe.Exception;
import sys.io.File;
import python.FileUtils;
import sys.FileSystem;

class Run {
	static function main() {
		var command:String = Sys.args()[0];
		switch (command) {
			case "cp":
				var file = Sys.args()[1];
				var to = Sys.args()[2];
				if (FileSystem.isDirectory(file)) {
					FileUtils.copyDic(file, to);
				} else {
					FileUtils.copyFile(file, to);
				}
			case "rm":
				var del = Sys.args()[1];
				var ext = Sys.args()[2];
				trace("rm " + del + " " + ext);
				if (ext.indexOf("*") == 0) {
					// 批量删除逻辑
					ext = StringTools.replace(ext, "*", "");
					if (FileSystem.isDirectory(del)) {
						var files = FileSystem.readDirectory(del);
						for (file in files) {
							if (!FileSystem.isDirectory(file) && file.indexOf(ext) != -1) {
								try {
									FileSystem.deleteFile(del + "/" + file);
									trace("Delete:", file);
								} catch (e:Exception) {}
							}
						}
					} else {
						throw "这不是一个文件夹";
					}
				} else {
					trace("Delete:", del);
					// 单文件删除
					if (FileSystem.isDirectory(del)) {
						FileUtils.removeDic(del);
					} else {
						FileSystem.deleteFile(del);
					}
				}
			case "bytes":
				// 检查文件是否为二进制
				var dir:String = Sys.args()[1];
				var exxt:String = Sys.args()[2];
				var files = FileSystem.readDirectory(dir);
				for (file in files) {
					if (file.indexOf(exxt) != -1) {
						if(FileUtils.isBinary(dir + "/" + file)){
							trace("二进制文件：" + file);
						}
					}
				}
			case "sign":
				// 签名文本比较
				var file:String = Sys.args()[1];
				var array = File.getContent(file).split("\n");
				var text1 = array[0];
				var text2 = array[1];
				for (i in 0...text1.length) {
					var a1 = text1.charAt(i);
					var a2 = text2.charAt(i);
					if(a1 != a2){
						trace("line=",i,text1.substr(0,i));
						break;
					}
				}
		}
	}
}
