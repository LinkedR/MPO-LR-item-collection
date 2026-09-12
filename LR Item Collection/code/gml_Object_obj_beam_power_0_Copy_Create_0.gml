cannon_align();
spazer_id = LRscr_helper_default(self, "passSpazer", 0);

if (dz("Spazer"))
    hasSpazer = true;
else
    hasSpazer = false;

if (dz("LRItems Nova Beam"))
{
    damage *= 2;
    sprite_index = LRspr_Beam_Nova_main;
    isNovaShot = true;
}
else
{
    isNovaShot = false;
}

if (!hasSpazer)
{
    bitsound(sndBeamPower);
    
    if (isNovaShot)
        become_charge_shot(LRspr_Beam_Nova_charged, sndBeamPowerCharged, sndBeamPower, 25);
    else
        become_charge_shot(sprPowerBeamCharged, sndBeamPowerCharged, sndBeamPower, 25);
    
    if (instance_number(obj_beam_power_0) > 13)
    {
        with (obj_beam_power_0)
        {
            if (id != other.id && !irandom(2))
                instance_destroy();
        }
    }
}
else
{
    spazer_counter = 0;
    
    if (spazer_id == 0)
    {
        with (mom)
        {
            for (var i = 1; i < 3; i++)
            {
                LRscr_helper_instance_create(x, y, LRobj_beam_power, 
                {
                    passSpazer: i
                });
            }
        }
    }
    
    bitsound(sndBeamSpazer);
    charge_factor = 25;
    
    if (spazer_id > 0)
        charge_factor = 3;
    
    if (isNovaShot)
        become_charge_shot(LRspr_Beam_Nova_charged, sndBeamSpazerCharged, sndBeamSpazer, charge_factor);
    else
        become_charge_shot(sprPowerBeamCharged, sndBeamSpazerCharged, sndBeamSpazer, charge_factor);
    
    spazer_delay = 3;
}

get_hefty();
image_angle = angle;

if (charged && dz("Proximity Beam") && spazer_id == 0)
    spawn(obj_aeon_charge_slash_0);
