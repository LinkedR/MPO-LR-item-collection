image_index = unlocked;

with (partner)
{
    if (gate_id == other.gate_id && other.unlocked)
        image_yscale = lerp(image_yscale, 0, 0.05);
}

if (unlocked)
{
    ds_write(key, 1);
    exit;
}

bleft = x + 4;
bright = x + 4 + 18;
bup = y;
bdown = y + 16;

if (image_xscale == -1)
{
    bleft = x - 8 - 18;
    bright = x - 8;
}

weap = collision_rectangle(bleft, bup, bright, bdown, par_weapon, 0, 1);

if (instance_exists(weap))
{
    // ----- LRedit : included custom wave into the logic -----
    if ((((weap.xstart > x && sign(image_xscale) == 1) || (weap.xstart < x && sign(image_xscale) == -1)) && (weap.is_beam || weap.is_missile)) || (weap.object_index == obj_beam_wave_0 || weap.object_index == LRobj_beam_wave))
    {
        // ----------------------------------------------------
        bitsound(snd_gate);
        
        if (sign(image_xscale) == 1)
            instance_create(x + 8, y, obj_effect_clink);
        else
            instance_create(x - 8 - 16, y, obj_effect_clink);
        
        unlocked = 1;
    }
}

if (ds_zero(key))
    unlocked = 1;
