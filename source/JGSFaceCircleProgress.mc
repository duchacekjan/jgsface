class JGSFaceCircleProgress{
    private var mRadius;
    var leadColor = Graphics.COLOR_DK_GRAY;
    var progressColor = new JGSFaceColorLevels(Graphics.COLOR_GREEN);
    var isLeadVisible = true;
    var stroke = 4;
    var font = Graphics.FONT_SMALL;
    var isProgressTextVisible = false;
    var isReverse = false;

    function initialize(radius){
        mRadius = radius;
    }

    function drawCircleProgress(dc as Dc, x, y, percentageProgress){
        drawLead(dc, x, y);
        drawProgress(dc, x, y, percentageProgress);
        drawProgressText(dc, x, y, percentageProgress);
    }

    private function drawLead(dc as Dc, x, y){
        if(!isLeadVisible){
            return;
        }

        dc.setColor(leadColor, Graphics.COLOR_TRANSPARENT);
        dc.drawCircle(x, y, mRadius);        
    }

    private function drawProgressText(dc as Dc, x, y, percentageProgress){
        if(!isProgressTextVisible){
            return;
        }
        var text = Lang.format("$1$", [percentageProgress.format("%01d")]);
        if(percentageProgress<100){
            text = text+"%";
        }
        var justify = Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER;
        dc.drawText(x, y, font, text, justify);
    }

    private function drawProgress(dc as Dc, x, y, percentageProgress){
        var progressValue = percentageProgress;
        if (percentageProgress > 100.0){
            progressValue = 100.0;
        }
        var progressLevel = (360 * progressValue/100.0).toNumber();
        var color = getProgressColor(progressValue);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        var topLevel = 90.0;
        dc.setPenWidth(stroke);
        var arcEnd = topLevel - progressLevel;
        if (arcEnd < 0) {
            arcEnd = 360 + arcEnd;
        }
        var arc = Graphics.ARC_CLOCKWISE;
        if(isReverse){
            arc = Graphics.ARC_COUNTER_CLOCKWISE;
        }
        dc.drawArc(x, y, mRadius, arc, topLevel, arcEnd);
        dc.setPenWidth(1);
    }

    private function getProgressColor(percentageProgress) as Color{
        return progressColor.getColor(percentageProgress);
    }
}