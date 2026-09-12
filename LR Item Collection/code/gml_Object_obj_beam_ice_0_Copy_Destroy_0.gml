if (!charged)
    instance_create(x, y, obj_splat_ice_0);
else
    instance_create(x, y, obj_splat_ice_1);

if (dz("Ice Spreader"))
{
    var t_beamInstance = dz("LRItems Dark Ice") ? LRobj_beam_ice_darkSpread : obj_beam_ice_spread;
    
    if (!charged)
    {
        repeat (8)
        {
            instance_create(x, y, t_beamInstance);
            spread_angle += 45;
        }
    }
    
    if (charged)
    {
        repeat (16)
        {
            instance_create(x, y, t_beamInstance);
            spread_angle += 24;
        }
    }
}
