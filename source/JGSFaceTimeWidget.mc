class JGSFaceTimeWidget extends JGSFaceWidget{
    private var x = 240;
    private var y = 30;
    private var hoursForegroundColor = Graphics.COLOR_TRANSPARENT;
    private var minsForegroundColor = Graphics.COLOR_LT_GRAY;
    private var hoursBorderColor = 0xf8f800;
    private var minsBorderColor = Graphics.COLOR_WHITE;
    private var borderFont = null;
    private var font = null;
    private var xOffset = -2;
    private var horizontalJustification = Graphics.TEXT_JUSTIFY_RIGHT;
    
    function initialize(){
        JGSFaceWidget.initialize();    
    }

    function loadResourcesCore(){
        borderFont = Application.loadResource(Rez.Fonts.contouredBFont);
        font = Application.loadResource(Rez.Fonts.contouredFont);
    }

    function updateCore(dc){
        xOffset = -2;
        horizontalJustification = Graphics.TEXT_JUSTIFY_RIGHT;
        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        drawContouredText(dc, hourString, hoursBorderColor, hoursForegroundColor, y+50);
        drawContouredText(dc, minString, minsBorderColor, minsForegroundColor, y+155);
    }

    function updateInLowPowerMode(dc){
        xOffset = -120;
        horizontalJustification = Graphics.TEXT_JUSTIFY_CENTER;
        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        drawContouredText(dc, hourString, Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT, y+50);
        drawContouredText(dc, minString, Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT, y+155);
    }

    function freeResourcesCore(){
        borderFont = null;
        font = null;
    }

    private function drawContouredText(dc, text, borderColor, color, y){
        drawColoredText(dc, text, borderColor, y, borderFont);
        drawColoredText(dc, text, color, y, font);
    }

    private function drawColoredText(dc, text, color, y, font){
        var justify = horizontalJustification|Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x+xOffset,y,font,text,justify);
    }
}