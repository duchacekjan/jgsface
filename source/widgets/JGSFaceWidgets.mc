class JGSFaceWidgets{
    private var mWidgets;
    private var mFonts;

    function initialize(){
        mWidgets = new [6];
        mWidgets[0] = new JGSFaceWeatherWidget();
        mWidgets[1] = new JGSFaceTimeWidget();
        mWidgets[2] = new JGSFaceDateWidget();
        mWidgets[3] = new JGSFaceProgressWidget();
        mWidgets[4] = new JGSFaceInfoWidget();
        //mWidgets[5] = new JGSFaceChargingWidget();
    }

    function loadResources(){
        for(var i = 0; i < mWidgets.size();i += 1){
            var widget = mWidgets[i];
            if(widget !=null and (widget instanceof JGSFaceWidget)){
                widget.loadResources();
            }
        }
    }

    function update(dc, inLowPowerMode){
        for(var i = 0; i < mWidgets.size();i += 1){
            var widget = mWidgets[i];
            if(widget !=null and (widget instanceof JGSFaceWidget)){
                widget.update(dc, inLowPowerMode);
            }
        }
    }

    function freeResources(){
        for(var i = 0; i < mWidgets.size();i += 1){
            var widget = mWidgets[i];
            if(widget !=null and (widget instanceof JGSFaceWidget)){
                widget.freeResources();
            }
        }
    }
}