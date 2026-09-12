if (!isLightShot)
{
    cannon_step();
    beam_hit_wall();
    
    if (!place_meeting(x, y, obj_visual_mask_enemy))
    {
        beam_travel_straight(5.2 * abs(image_xscale), angle);
    }
    else
    {
        beam_travel_straight(1 * abs(image_xscale), angle);
        
        if (visible)
            image_xscale = lerp(image_xscale, 2 + hefty, 0.1);
    }
    
    if (!place_meeting(x, y, [par_player, obj_visual_mask_enemy]) && visible)
        image_xscale = lerp(image_xscale, image_xscale * (2.5 + hefty), 0.0666942);
    
    repeat (2)
    {
        _x = lengthdir_x(1, angle);
        _y = lengthdir_y(1, angle);
        
        if (position_meeting(x + _x, y + _y, par_solid) || position_meeting(x + (_x / 2), y + (_y / 2), par_solid) || position_meeting(x + (_x / 3), y + (_y / 3), par_solid) || position_meeting(x + (_x / 4), y + (_y / 4), par_solid) || position_meeting(x + (_x / 5), y + (_y / 5), par_solid))
        {
            x += _x;
            y += _y;
            image_xscale *= self.shrinkFactor;
        }
    }
    
    image_yscale = 1;
    image_xscale = clamp(image_xscale, -3, 3);
}
