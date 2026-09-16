arr = dz("Aeon");
arr_status = dz("Aeon Status");

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

selection_vertical(array_length(arr) - 1, sndPauseScroll);

if (global.key_cancel || global.key_menu)
{
    bitsound(sndPauseReject);
    leaving = 1;
    exit;
}

if (global.key_accept && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    if (aeon < aeon_max && arr_status[selection] == 0)
    {
        arr_status[selection] = 1;
        ds_write("Aeon Status", arr_status);
        bitsound(sndPauseSelect);
        exit;
    }
    
    if (arr_status[selection] == 1)
    {
        arr_status[selection] = 0;
        ds_write("Aeon Status", arr_status);
        bitsound(sndPauseReject);
        exit;
    }
    
    if (aeon >= aeon_max && arr_status[selection] == 0)
    {
        bitsound(sndPauseCancel, 2/3);
        shaky = 11;
        exit;
    }
}
