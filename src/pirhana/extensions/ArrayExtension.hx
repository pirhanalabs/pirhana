package pirhana.extensions;

class ArrayExtension{

      public static function each<T>(a:Array<T>, fn:T->Void){
            for (val in a){
                  fn(val);
            }
      }

      public static function eachsafe<T>(a:Array<T>, fn:T->Void){
            for (val in a.iterator()){
                  fn(val);
            }
      }
}