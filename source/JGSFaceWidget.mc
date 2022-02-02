class JGSFaceWidget{
    
    protected var isVisible = false;
    protected var isLowPowerMode = false;

    function initialize(){  
    }

    function loadResources(){
        isVisible = true;
        loadResourcesCore();
    }

    function update(dc, isLowPowerMode){
        isLowPowerMode = isLowPowerMode;
        if(!isVisible){
            return;
        }

        if(isLowPowerMode || Common.isInSleepMode()){
            updateInLowPowerMode(dc);
        }else{
            updateCore(dc);
        }
    }

    function freeResources(){
        freeResourcesCore();
        isVisible = false;
    }

    protected function freeResourcesCore(){
    }

    protected function loadResourcesCore(){
    }

    protected function updateCore(dc){
    }

    protected function updateInLowPowerMode(dc){        
    }
}