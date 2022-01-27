class JGSFaceCommon{
    function initialize(){
        
    }
   

    function drawDateString( dc, x, y ) {
        var info = Time.Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$", [info.month, info.day]);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var offset = dc.getFontHeight(Graphics.FONT_TINY);
       	dc.drawText(x, y, Graphics.FONT_TINY, dateStr, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);   
        dc.drawText(x, y+offset, Graphics.FONT_TINY, info.day_of_week, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

    
}