if (global.key_up)
    selection_dir = -1;

if (global.key_down)
    selection_dir = 1;

if (!can_artifact && selection == 1)
    selection += selection_dir;

if (!can_teleport && selection == 0)
    selection += selection_dir;

if (instance_exists(obj_teleporter))
    leaving = 1;

if (!leaving)
{
    menu_offset = lerp(menu_offset, 0, 0.1);
}
else
{
    menu_offset = lerp(menu_offset, global._screen_height * 2, 0.1);
    
    if (menu_offset > ((global._screen_height * 2) - 32))
        instance_destroy();
}

if (instance_exists(par_submenu) || leaving)
{
    menu_offset = lerp(menu_offset, global._screen_height * 2, 0.1);
    exit;
}

selection_vertical(3, sndPauseScroll); // ----- LRedit : increased choices -----

if (global.key_cancel || (global.key_accept && selection == 3)) // ---- LRedit : changed exit index -----
{
    bitsound(sndPauseReject);
    leaving = 1;
    exit;
}

if (global.key_accept && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    bitsound(sndPauseSelect);
    
    if (selection == 0)
        spawn(submenu_teleport);
    
    if (selection == 1)
        spawn(submenu_artifacts);
    
    // ----- LRedit : item toggle -----
    if (selection == 2)
        spawn(LRobj_submenu_items);
    // --------------------------------
}
