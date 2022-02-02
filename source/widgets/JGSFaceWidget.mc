class JGSFaceWidget{    
    function initialize(){  
    }

    function update(dc, inLowPowerMode){
        if(!Common.Widgets.isVisible){
            return;
        }
        
        if(inLowPowerMode){
            updateInLowPowerMode(dc);
        }else{
            if(getIsCharging()){
                updateInChargingMode(dc);
            }else{
                updateCore(dc);
            }
        }
    }

    protected function updateCore(dc){
    }

    protected function updateInLowPowerMode(dc){        
    }

    protected function updateInChargingMode(dc){

    }

    private function getIsCharging(){
        var stats = System.getSystemStats();
        if(stats has :charging){
            return stats.charging;
        }else{
            return false;
        }
    }
}