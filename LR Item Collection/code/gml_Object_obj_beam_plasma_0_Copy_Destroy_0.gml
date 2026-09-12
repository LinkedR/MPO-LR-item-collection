var t_location_x = x;
var t_location_y = y;

if (isLightShot)
{
    t_location_x = lightImpact_x;
    t_location_y = lightImpact_y;
}

if (!charged)
    instance_create(t_location_x, t_location_y, obj_splat_plasma_0);
else
    instance_create(t_location_x, t_location_y, obj_splat_plasma_1);
