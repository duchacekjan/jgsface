class JGSFaceDateWidget extends JGSFaceWidget{
    private const startX = 0;
    private const startY = 100;
    private var x;
    private var y;
    
    function initialize(){    
        JGSFaceWidget.initialize();
        x = startX + 35 + 5;
        y = startY;
    }

    function updateCore(dc){
        var info = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$", [info.month, info.day]);
        dc.setColor(Colors.DATE_FOREGROUND, Colors.EMPTY);
        var offset = dc.getFontHeight(Graphics.FONT_TINY)+5;
       	dc.drawText(x, y, Graphics.FONT_TINY, dateStr, TextJustification.C);   
        dc.drawText(x, y+offset, Graphics.FONT_TINY, info.day_of_week, TextJustification.C);
    }    

    function updateInChargingMode(dc){        
        var info = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$ $3$", [info.month, info.day, info.day_of_week]);
        dc.setColor(Colors.DATE_FOREGROUND, Colors.EMPTY);
       	dc.drawText(60, 220, Graphics.FONT_TINY, dateStr, TextJustification.CC);   
    }
}