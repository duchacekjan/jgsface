class JGSFaceTimeWidget extends JGSFaceWidget{
    private var x = 240;
    private var y = 30;
    private var hoursForegroundColor = Colors.EMPTY;
    private var minsForegroundColor = Graphics.COLOR_LT_GRAY;
    private var hoursBorderColor = 0xf8f800;
    private var minsBorderColor = Graphics.COLOR_WHITE;
    private var borderFont = null;
    private var font = null;
    
    function initialize(){
        JGSFaceWidget.initialize();   
        Toybox.Math.srand(System.getTimer()); 
    }

    function loadResourcesCore(){
        borderFont = Application.loadResource(Rez.Fonts.contouredBFont);
        font = Application.loadResource(Rez.Fonts.contouredFont);
    }

    function updateCore(dc){
        var clockTime = System.getClockTime();
        var hourString = Lang.format("$1$", [clockTime.hour.format("%02d")]);
        var minString = Lang.format("$1$", [clockTime.min.format("%02d")]);
        drawContouredText(dc, hourString, Colors.TIME_HRS, y+50);
        drawContouredText(dc, minString, Colors.TIME_MINS, y+155);
    }

    function updateInLowPowerMode(dc){
        var clockTime = System.getClockTime();
        var text = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        var xOffset = getRandom();
        var yOffset = getRandom();
        dc.setColor(Colors.TIME_MINS.foreground, Colors.EMPTY);
        dc.drawText(120 + xOffset, 120 + yOffset, Graphics.FONT_NUMBER_MILD, text, TextJustification.CC);
    }

    function freeResourcesCore(){
        borderFont = null;
        font = null;
    }

    private function drawContouredText(dc, text, color as ClockColors, y){
        drawColoredText(dc, text, color.border, y, borderFont);
        drawColoredText(dc, text, color.foreground, y, font);
    }

    private function drawColoredText(dc, text, color, y, font){
        dc.setColor(color, Colors.EMPTY);
        dc.drawText(x-2,y,font,text,TextJustification.RC);
    }

    private function getRandom(){
        var random = Toybox.Math.rand() % 85;
        var sign = 1;
        if(Toybox.Math.rand() % 2 ==0){
            sign = -1;
        }
        return Toybox.Math.round(sign * random);
    }
}