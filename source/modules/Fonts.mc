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
        // mFonts = new [7];
        // mFonts[0] = Application.loadResource(Rez.Fonts.weatherFont);
        // mFonts[1] = Application.loadResource(Rez.Fonts.iconsFont);
        // mFonts[2] = Application.loadResource(Rez.Fonts.smallFont);
        // mFonts[3] = Application.loadResource(Rez.Fonts.infoFont);
        // mFonts[4] = Application.loadResource(Rez.Fonts.contouredFont);
        // mFonts[5] = Application.loadResource(Rez.Fonts.contouredBFont);
        // mFonts[7] = null; //Application.loadResource(Rez.Fonts.iconsBigFont); TODO
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