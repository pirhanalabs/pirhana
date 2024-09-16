package pirhana.heaps.anims;

import pirhana.utils.state.IEventState;

class AnimationNodeEvent implements IEventState{

    final node:AnimationNode;

    /**
        A simple event to use node animation as events.
        This is useful for sequencing multiple complex animations.
    **/
    public function new(node:AnimationNode){
        this.node = node;
        this.node.paused = true;
    }

    public function onEnter(){
        this.node.paused = false;
    }

    public function update(frame:Frame){
        // this does nothing. Updates handled by AnimationManager.
    }

    public function postupdate(){
        // this does nothing. postupdate handled by AnimationManager.
    }

    public function isFinished(){
        return node.completed;
    }
}