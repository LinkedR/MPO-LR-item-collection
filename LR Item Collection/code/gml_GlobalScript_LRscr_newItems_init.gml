function LRscr_items_generate()
{
    ds_write("LRItems Dark Ice", 0);
    ds_write("LRItems Light Blaze", 0);
    ds_write("LRItems Annihilating Wave", 0);
    ds_write("LRItems Life Drain", 0);
    ds_write("LRItems Cooling Module", 0);
    ds_write("LRItems Defrost Module", 0);
    ds_write("LRItems Antistatic Module", 0);
    ds_write("LRItems Spacier Jump", 0);
    ds_write("LRItems Nova Beam", 0);
    ds_write("LRItems Impact Boost", 0);
    ds_write("LRItems Flash Shift", 0);
    ds_write("LRItems Phazon Overload", 0);
    ds_write("LRItems Ascension Shift", 0);
}

function LRscr_items_toggle()
{
    //exit;
    
    if (keyboard_check_pressed(vk_f1))
    {
        var t_powerUp = "LRItems Phazon Overload";
        
        if (dz(t_powerUp))
            ds_write(t_powerUp, 0);
        else
            ds_write(t_powerUp, 1);
    }
    
    if (keyboard_check_pressed(vk_f2))
    {
        var t_powerUp = "LRItems Flash Shift";
        
        if (dz(t_powerUp))
            ds_write(t_powerUp, 0);
        else
            ds_write(t_powerUp, 1);
    }
    
    if (keyboard_check_pressed(vk_f3))
    {
        instance_create_depth(mouse_x,mouse_y,-100,obj_block_phazon);
    }
}
