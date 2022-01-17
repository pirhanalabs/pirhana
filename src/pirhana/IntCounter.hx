package pirhana;

class IntCounter{

    var val = 0;

    public function new(){

    }

    public function getNextInt(){
        return val++;
    }

    public function reset(){
        val = 0;
    }
}