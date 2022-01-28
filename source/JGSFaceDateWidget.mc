class JGSFaceDateWidget extends JGSFaceWidget{
    private const startX = 0;
    private const startY = 100;
    private var x;
    private var y;
    private var foregroundColor = Graphics.COLOR_WHITE;
    
    function initialize(){    
        JGSFaceWidget.initialize();
        x = startX + 35 + 5;
        y = startY;
    }

    function updateCore(dc){
        var info = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$", [info.month, info.day]);
        dc.setColor(foregroundColor, Graphics.COLOR_TRANSPARENT);
        var offset = dc.getFontHeight(Graphics.FONT_TINY)+5;
       	dc.drawText(x, y, Graphics.FONT_TINY, dateStr, Graphics.TEXT_JUSTIFY_CENTER);   
        dc.drawText(x, y+offset, Graphics.FONT_TINY, info.day_of_week, Graphics.TEXT_JUSTIFY_CENTER);
    }
}