function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        UP,
        DOWN,
        LEFT,
        RIGHT,
        
        AIM_UP,
        AIM_DOWN,
        AIM_LEFT,
        AIM_RIGHT,
        
        DASH,
        ATTACK,
        SWITCH,
        
        ACCEPT,
        BACK,
    }
    
    enum INPUT_CLUSTER
    {
        NAVIGATION,
        AIM,
    }
    
    InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
    InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
    InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
    InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
    InputDefineVerb(INPUT_VERB.AIM_UP,  "aim_up",     -1,                  -gp_axisrv);
    InputDefineVerb(INPUT_VERB.AIM_DOWN,"aim_down",   -1,                   gp_axisrv);
    InputDefineVerb(INPUT_VERB.AIM_LEFT,"aim_left",   -1,                  -gp_axisrh);
    InputDefineVerb(INPUT_VERB.AIM_RIGHT,"aim_right", -1,                   gp_axisrh);
    InputDefineVerb(INPUT_VERB.DASH,    "dash",       [vk_space, vk_enter, vk_shift], [gp_face1, gp_face2, gp_face3, gp_face4]);
    InputDefineVerb(INPUT_VERB.ATTACK,  "attack",     [vk_space, vk_enter, mb_left], [gp_face1, gp_face3, gp_shoulderr, gp_shoulderrb]);
    InputDefineVerb(INPUT_VERB.SWITCH,  "switch",     [vk_shift, mb_right], [gp_face2, gp_face4, gp_shoulderl, gp_shoulderlb]);
    InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",     [vk_space, vk_enter], gp_face1);
    InputDefineVerb(INPUT_VERB.BACK,    "back",       [vk_backspace, vk_escape],    [gp_start, gp_select]);
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
    InputDefineCluster(INPUT_CLUSTER.AIM, INPUT_VERB.AIM_UP, INPUT_VERB.AIM_RIGHT, INPUT_VERB.AIM_DOWN, INPUT_VERB.AIM_LEFT);
}
