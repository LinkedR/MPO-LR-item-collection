cannon_align();

if (!ds_zero("Ice Spreader"))
{
    bitsound(sndBeamIce);
    become_charge_shot(sprIceBeamCharged, sndBeamIceCharged, sndBeamIce, 3);
}
else
{
    bitsound(sndBeamIceSpreader);
    spread_angle = 0;
    
    if (object_index == LRobj_beam_ice)
    {
        with (par_player)
        {
            LRscr_helper_instance_create(x, y, LRobj_beam_ice_sub, 
            {
                angleAdd: 11
            });
            LRscr_helper_instance_create(x, y, LRobj_beam_ice_sub, 
            {
                angleAdd: -11
            });
        }
    }
}

if (charged && dz("Proximity Beam"))
    spawn(obj_aeon_charge_slash_2);

get_hefty();
