isMain = !LRscr_helper_default(self, "notMain", false);
cannon_align();
isAnnihilator = dz("LRItems Annihilating Wave") ? true : false;

if (!dz("Wavebuster") || !isMain)
{
    bitsound(sndBeamWave);
    charge_factor = 6.666666666666667;
    
    if (isAnnihilator)
    {
        become_charge_shot(LRspr_Beam_Annihilator_upgrade, sndBeamWaveCharged, sndBeamWave, charge_factor);
        sprite_index = LRspr_Beam_Annihilator_main;
    }
    else
    {
        become_charge_shot(sprWaveBeamCharged, sndBeamWaveCharged, sndBeamWave, charge_factor);
    }
    
    global.wave_orientation *= -1;
    wavelength = 3.6 * global.wave_orientation;
    
    if (ds_zero("Wavebuster") == 1)
        wavelength *= 1.89;
    
    if (isMain && ds_zero("Wavebuster") != 1)
    {
        with (mom)
        {
            LRscr_helper_instance_create(x, y, LRobj_beam_wave, 
            {
                notMain: true
            });
        }
    }
}
else
{
    bitsound(sndBeamWaveBuster);
    
    if (isAnnihilator)
    {
        become_charge_shot(LRspr_Beam_Annihilator_upgrade, sndBeamWaveCharged, sndBeamWaveBuster, 6.666666666666667);
        sprite_index = LRspr_Beam_Annihilator_upgrade;
    }
    else
    {
        become_charge_shot(sprWaveBeamCharged, sndBeamWaveCharged, sndBeamWaveBuster, 6.666666666666667);
    }
    
    global.wave_orientation *= -1;
    wavelength = 0 * global.wave_orientation;
    
    with (mom)
    {
        repeat (2)
        {
            var t_beam = LRscr_helper_instance_create(x, y, LRobj_beam_wave, 
            {
                notMain: true
            });
            t_beam.damage = other.damage;
            t_beam.damage_mod = other.damage_mod;
        }
    }
}

if (isAnnihilator)
    exponentialDamage = 1;

if (layer_exists("Tiles"))
    depth = -270;

get_hefty();

if (isMain)
{
    if (charged && dz("Proximity Beam"))
        spawn(obj_aeon_charge_slash_1);
}
