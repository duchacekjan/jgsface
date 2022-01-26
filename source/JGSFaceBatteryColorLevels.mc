class JGSFaceBatteryColorLevels extends JGSFaceColorLevels{
    function initialize(){
        JGSFaceColorLevels.initialize(Graphics.COLOR_GREEN);
    }
    function getColor(value) as Color{
        var result = mDefaultColor;
        if(value<=10){
            result = Graphics.COLOR_RED;
        }else if (value<=50)
        {
            result = Graphics.COLOR_DK_BLUE;
        }else{
            result = Graphics.COLOR_GREEN;
        }
        return result;
    }
}