class JGSFaceTimeWidget extends JGSFaceWidget{
    private var x = 240;
    private var y = 30;
    private var hoursForegroundColor = Graphics.COLOR_TRANSPARENT;
    private var minsForegroundColor = Graphics.COLOR_LT_GRAY;
    private var hoursBorderColor = 0xf8f800;
    private var minsBorderColor = Graphics.COLOR_WHITE;
    private var borderFont = null;
    private var font = null;
    
    function initialize(){
        JGSFaceWidget.initialize();    
    }

    function loadResourcesCore(){
        borderFont = Application.loadResource(Rez.Fonts.contouredBFont);
        font = Application.loadResource(Rez.Fonts.contouredFont);
    }

    function updateCore(dc){
        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        drawContouredText(dc, hourString, hoursBorderColor, hoursForegroundColor, y+50);
        drawContouredText(dc, minString, minsBorderColor, minsForegroundColor, y+155);
    }

    function updateInLowPowerMode(dc){
        var clockTime = System.getClockTime();
        var text = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        var xOffset = getRandom();
        var yOffset = getRandom();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(120 + xOffset, 120 + yOffset, Graphics.FONT_NUMBER_MILD, text, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
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
        var justify = Graphics.TEXT_JUSTIFY_RIGHT|Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.drawText(x-2,y,font,text,justify);
    }

    private function getRandom(){
        Toybox.Math.srand(System.getTimer());
        var random = Toybox.Math.rand() % 60;
        var sign = 1;
        if(Toybox.Math.rand() % 2 ==0){
            sign = -1;
        }
        return Toybox.Math.round(sign * random);
    }
}