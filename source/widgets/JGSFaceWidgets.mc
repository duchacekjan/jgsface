class JGSFaceWidgets{
    private var mWidgets = null;
    var isVisible = false;

    function initialize(){
        mWidgets = new [6];
        mWidgets[0] = new JGSFaceWeatherWidget();
        mWidgets[1] = new JGSFaceTimeWidget();
        mWidgets[2] = new JGSFaceDateWidget();
        mWidgets[3] = new JGSFaceProgressWidget();
        mWidgets[4] = new JGSFaceInfoWidget();
        mWidgets[5] = new JGSFaceChargingWidget();
    }

    function loadResources(){
        isVisible = true;
        Fonts.initialize();
        Fonts.loadFont(Fonts.Weather, Application.loadResource(Rez.Fonts.weatherFont));
        Fonts.loadFont(Fonts.Icons, Application.loadResource(Rez.Fonts.iconsFont));
        Fonts.loadFont(Fonts.Small, Application.loadResource(Rez.Fonts.smallFont));
        Fonts.loadFont(Fonts.ExtraSmall, Application.loadResource(Rez.Fonts.extraSmallFont));
        Fonts.loadFont(Fonts.ContouredForeground, Application.loadResource(Rez.Fonts.contouredFont));
        Fonts.loadFont(Fonts.ContouredBackground, Application.loadResource(Rez.Fonts.contouredBFont));
        Fonts.loadFont(Fonts.IconsBig, Application.loadResource(Rez.Fonts.iconsBigFont));
    }

    function update(dc, inLowPowerMode){
        for(var i = 0; i < mWidgets.size();i += 1){
            updateWidget(mWidgets[i], dc, inLowPowerMode);
        }
    }

    function freeResources(){
        isVisible = false;
        Fonts.freeFonts();
    }

    private function updateWidget(widget, dc, inLowPowerMode){
        if(widget !=null and (widget instanceof JGSFaceWidget)){
            widget.update(dc, inLowPowerMode);
        }
    }
}