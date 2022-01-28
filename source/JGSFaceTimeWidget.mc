class JGSFaceTimeWidget{
    private var x = 240;
    private var y = 30;
    private var hoursForegroundColor = Graphics.COLOR_TRANSPARENT;
    private var minsForegroundColor = Graphics.COLOR_LT_GRAY;
    private var hoursBorderColor = 0xf8f800;
    private var minsBorderColor = Graphics.COLOR_WHITE;
    private var borderFont = null;
    private var font = null;
    
    function initialize(){    
    }

    function loadResources(){
        borderFont = Application.loadResource(Rez.Fonts.contouredBFont);
        font = Application.loadResource(Rez.Fonts.contouredFont);
    }

    function update(dc){
        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        drawContouredText(dc, hourString, hoursBorderColor, hoursForegroundColor, y+50);
        drawContouredText(dc, minString, minsBorderColor, minsForegroundColor, y+155);
    }

    function freeResources(){
        borderFont = null;
        font = null;
    }

    private function drawContouredText(dc, text, borderColor, color, y){
        drawColoredText(dc, text, borderColor, y, borderFont);
        drawColoredText(dc, text, color, y, font);
    }

    private function drawColoredText(dc, text, color, y, font){
        var justify = Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x-2,y,font,text,justify);
    }
}