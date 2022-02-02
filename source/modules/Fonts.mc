module Fonts{
    const Weather = 0;
    const Icons = 1;
    const Small = 2;
    const ExtraSmall = 3;
    const ContouredForeground = 4;
    const ContouredBackground = 5;
    const IconsBig = 6;

    var mFonts = null;
    
    function initialize(){
        mFonts = new [7];
    }

    function loadFont(id, font){
        mFonts[id] = font;
    }

    function get(font){
        return mFonts[font];
    }

    function freeFonts(){        
        for(var i = 0; i < mFonts.size();i += 1){
            mFonts[i] = null;
        }
        mFonts = null;
    }
}