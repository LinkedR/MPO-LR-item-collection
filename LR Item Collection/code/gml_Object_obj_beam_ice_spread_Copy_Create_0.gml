if (!instance_exists(mom))
{
    instance_destroy();
    exit;
}

speed = 8;
direction = mom.spread_angle;
image_angle = direction;
alarm[0] = 12;
mask_index = spr_nothing;
