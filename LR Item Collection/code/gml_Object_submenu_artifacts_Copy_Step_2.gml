if (!leaving)
{
    menu_offset = lerp(menu_offset, 0, 0.1);
}
else
{
    menu_offset = lerp(menu_offset, global._screen_height, 0.1);
    
    if (menu_offset > (global._screen_height - 32))
        instance_destroy();
}

if (menu_offset > 32)
    exit;

if global.key_down
    selection_dir = 1;
if global.key_up
    selection_dir = -1;

selection_vertical(item_quantity - 1, sndPauseScroll);

var t_skipEntry = item_list[selection];
if t_skipEntry == "g"
{
    selection += selection_dir;
    if selection >= item_quantity
    {
        selection = 0;
    }
    if selection < 0
    {
        selection = item_quantity - 1;
    }
}

if (global.key_cancel || global.key_menu)
{
    bitsound(sndPauseReject);
    leaving = 1;
    exit;
}

if (global.key_accept && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    var t_itemIndex = item_list[selection];
    
    if t_itemIndex != "g"
    {
        if dz(t_itemIndex) != 0
        {
            // Item collected already, allow toggle
            ds_write(t_itemIndex, -dz(t_itemIndex));
        }
    }
}

if (shaky > 0)
    shaky -= 1;
