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
		}
	}
}
