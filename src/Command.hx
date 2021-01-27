class Command {
    
    static function main() {
        var path = Sys.args().pop();
        Sys.setCwd(path);
        trace("runDir:" + path);
        Sys.command("python3 " + StringTools.replace(Sys.programPath(),"run.n","bin/tools.py " + Sys.args().join(" ")));
    }

}