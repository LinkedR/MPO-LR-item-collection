event_inherited();

if (!hasSpazer)
{
    if (object_index != obj_combo_power && !isNovaShot)
        image_angle = 0;
}
else
{
    if (spazer_delay > 0)
    {
        spazer_delay -= 1;
        exit;
    }
    
    if (spazer_counter > 4)
        exit;
    
    spazer_counter += 1;
    
    if (spazer_id == 1)
    {
        x += lengthdir_x(2, angle + 90);
        y += lengthdir_y(2, angle + 90);
    }
    
    if (spazer_id == 2)
    {
        x += lengthdir_x(2, angle - 90);
        y += lengthdir_y(2, angle - 90);
    }
    
    image_angle = angle;
}
