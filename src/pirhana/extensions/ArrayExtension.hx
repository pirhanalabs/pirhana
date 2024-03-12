package pirhana.extensions;

class ArrayExtension{

      public static function each<T>(a:Array<T>, fn:T->Void){
            for (val in a){
                  fn(val);
            }
      }

      public static function ieach<T>(a:Array<T>, fn:T->Int->Void){
            for (i in 0 ... a.length){
                  fn(val, i);
            }
      }

      public static function eachsafe<T>(a:Array<T>, fn:T->Void){
            for (val in a.iterator()){
                  fn(val);
            }
      }

      public static function pick<T>(a:Array<T>, ?seed:hxd.Rand){
            if (seed != null){
                  return MathTools.seeded_pick(a, seed);
            }else{
                  return MathTools.pick(a);
            }
      }
}