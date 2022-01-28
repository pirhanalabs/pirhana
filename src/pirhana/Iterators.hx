package pirhana;

class ReverseArrayIterator<T>{

    var a : Array<T>;
    var i : Int;

    public function new(a:Array<T>){
        this.a = a;
        this.i = a.length-1;
    }

    public function hasNext() return i >= 0;
    public function next() return a[i--];
}