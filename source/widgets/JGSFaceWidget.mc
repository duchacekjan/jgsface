class JGSFaceWidget{    
    protected var isLowPowerMode = false;

    function initialize(){  
    }

    function update(dc, isLowPowerMode){
        isLowPowerMode = isLowPowerMode;
        if(!Common.Widgets.isVisible){
            return;
        }

        if(isLowPowerMode || Common.isInSleepMode()){
            updateInLowPowerMode(dc);
        }else{
            updateCore(dc);
        }
    }

    protected function updateCore(dc){
    }

    protected function updateInLowPowerMode(dc){        
    }
}