class Main{

    public static function main()
        new Main();

    private function new(){
        var world = new pirhana.ecs.World();
        world.addSystem(new pirhana.ecs.System());     
    }
}