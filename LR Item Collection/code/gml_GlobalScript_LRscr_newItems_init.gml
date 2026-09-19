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
    ds_write("LRItems Psychic Bomb", 0);
    ds_write("LRItems Knowledge Exploit", 0);
}

function LRscr_items_toggle()
{
    //exit;
    
    if (keyboard_check_pressed(vk_f1))
    {
        var t_powerUp = "LRItems Knowledge Exploit";
        
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

function LRscr_items_KnowledgeExploit_calc()
{
    var t_multiplier = 1; // each 1 is a 100%
    global.LRstat_KnowledgeExploit_mul = 1 + ((dz("Logbook") / global.total_scans) * t_multiplier);
}
