if (!dz("LRItems Light Blaze"))
    isLightShot = false;
else
    isLightShot = true;

cannon_align();
damage = 3 + (charged * 2);
og_damage = 3 + (charged * 2);
i_frames = 2;

if (!isLightShot)
{
    if (angleVariant > 0)
    {
        angle += 2;
        dir = 1;
    }
    else
    {
        angle -= 2;
        dir = -1;
    }
    
    alarm[1] = 180;
    alarm[2] = 12;
}
else
{
    mask_index = LRspr_Beam_Light_sub_centre;
    visible = true;
    image_xscale = point_distance(x, y, lightImpact_x, lightImpact_y) / 16;
    image_angle = point_direction(x, y, lightImpact_x, lightImpact_y);
}

depth += 12;
