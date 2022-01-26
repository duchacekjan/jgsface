class JGSFaceColorLevels{
    protected var mDefaultColor = Graphics.COLOR_GREEN;
    function initialize(color as Color){        
        mDefaultColor = color;
    }

    function getColor(value) as Color{
        return mDefaultColor;
    }
}