if (room == imp_Phazon_Infusion_Chamber || room == imp_Subchamber_One || room == imp_Subchamber_Two || room == imp_Subchamber_Three)
    phazon_beam = 0;

if (y > (room_height + 64))
    oob += 1;
else
    oob = 0;

if (instance_exists(obj_elevator_transition) || global.cutscene || pose)
    oob = 0;

if (oob >= 69)
    instance_create(x, y + yspeed, obj_spikes_0);

if (no_grip)
    no_grip -= 1;

if (ball)
    audio_stop_sound(sndSamusBallOut);

if (dz("Gravity Suit") == 1 && (place_meeting(x, y, par_water) || place_meeting(x, y, par_lava) || place_meeting(x, y, par_acid)))
    gravitying = 1;
else
    gravitying = 0;

if (changing_beam > 0)
    changing_beam -= 1;

if ((ds_zero_options("Dual Stick") && global.key_beam_hold) || !ds_zero_options("Dual Stick"))
{
    if ((global.key_beam_1 || global.key_beam_2 || global.key_beam_3 || global.key_beam_0) && changing_beam <= 0)
    {
        charge_counter = 0;
        beam_charged = 0;
        changing_beam = 15;
        
        function beam_rejected(arg0)
        {
            if (!ds_zero(arg0))
                bitsound(sndSamusAim);
        }
        
        if (global.key_beam_0 && ds_zero("Power Beam"))
        {
            ds_add("Beam Changes", 1);
            ds_write("Beam", 0);
            bitsound(sndSamusLockOn);
        }
        
        if (global.key_beam_1 && ds_zero("Wave Beam"))
        {
            ds_add("Beam Changes", 1);
            ds_write("Beam", 1);
            bitsound(sndSamusLockOn);
        }
        else
        {
            beam_rejected("Wave Beam");
        }
        
        if (global.key_beam_2 && ds_zero("Ice Beam"))
        {
            ds_add("Beam Changes", 1);
            ds_write("Beam", 2);
            bitsound(sndSamusLockOn);
        }
        else
        {
            beam_rejected("Ice Beam");
        }
        
        if (global.key_beam_3 && ds_zero("Plasma Beam"))
        {
            ds_add("Beam Changes", 1);
            ds_write("Beam", 3);
            bitsound(sndSamusLockOn);
        }
        else
        {
            beam_rejected("Plasma Beam");
        }
    }
}

aeon_counter += 1;

if (on_ground())
    just_grappled = 0;

can_move = 1;

if (global.scan_visor)
    can_move = 0;

if (clink > 0)
{
    if (clink == 7)
        earthquake(6);
    
    can_move = 0;
    clink -= 1;
}

if (global.cutscene)
{
    i_frames = 61;
    i_frames_chip = 2;
    can_move = 0;
}

if (hurt)
    can_move = 0;

if (pose)
    can_move = 0;

if (grip)
    can_move = 0;

if (climbing)
    can_move = 1;

if (grapple)
    can_move = 0;

if (crouch > 1)
    can_move = 0;

if (!can_move)
    xspeed *= 0.75;

if (cleets_flash > 0)
    cleets_flash -= 1;

if (recoil > 0)
    recoil -= 1;

if (missile_recoil > 0)
    missile_recoil -= 1;

if (i_frames > 0)
    i_frames -= 1;

if (i_frames_chip > 0)
{
    spider_charge = 0;
    spidering = 0;
    i_frames_chip -= 1;
}

if (aim_lock > 0)
    aim_lock -= 1;

if (aim_lenience > 0)
    aim_lenience -= 1;

if (pose > 0 && debug_mode && global.key_cancel)
    pose = 5;

speck_counter = (charge_counter / charge_max) * 8;

if (speck_counter > 8)
    speck_counter = 8;

repeat (speck_counter)
{
    if (irandom(6) == 0 && !ball)
        spawn(obj_effect_charge_speck);
}

// ----- LRedit : debuff immunity checks -----
if (burning > 0)
{
    if (dz("LRItems Cooling Module"))
    {
        burning = 0;
    }
    else
    {
        burning -= 1;
        
        if ((burning / 5) == round(burning / 5))
            ds_add("Energy", -1);
    }
}

if (frozen > 0)
{
    if (dz("LRItems Defrost Module"))
    {
        frozen = 0;
    }
    else
    {
        if (frozen > 11)
            frozen -= 3;
        
        can_move = 0;
        
        if (global.key_jump || global.key_left_tap || global.key_right_tap || global.key_up_tap || global.key_down_tap)
        {
            repeat (6)
                instance_create((x - 10) + irandom(20), (y - 9) + irandom(18), obj_effect_snow);
            
            bitsound(sndEnemyFreeze, 0.9);
            frozen -= 5;
            ice_shake = 11;
            
            if (frozen < 0)
                frozen = 0;
        }
        
        xspeed = 0;
        yspeed = 0;
    }
}

if (paralyzed > 0)
{
    if (dz("LRItems Antistatic Module"))
        paralyzed = 0;
    
    paralyzed -= 1;
}
// -----------------------------------------------

state_timer += 1;

if (burning > 0)
{
    if (position_meeting(x, y, obj_water_0))
        burning = 0;
    
    spawn_width = sprite_get_width(sprite_index);
    spawn_height = sprite_get_height(sprite_index);
    spawn_x = (x - (spawn_width / 2)) + irandom(spawn_width);
    spawn_y = (y - (spawn_height / 2)) + irandom(spawn_height);
    
    if (instance_number(obj_effect_flame) < 32 && (state_timer / 4) == round(state_timer / 4))
        instance_create(spawn_x, spawn_y, obj_effect_flame);
}

if (paralyzed > 0)
{
    spawn_width = sprite_get_width(sprite_index);
    spawn_height = sprite_get_height(sprite_index);
    spawn_x = (x - (spawn_width / 2)) + irandom(spawn_width);
    spawn_y = (y - (spawn_height / 2)) + irandom(spawn_height);
    
    if (instance_number(obj_effect_shock) < 32 && (state_timer / 4) == round(state_timer / 4))
        instance_create(spawn_x, spawn_y, obj_effect_shock);
}

if (ice_shake > 0)
    ice_shake -= 1;

if (mash > 0)
    mash -= 1;

mash = clamp(mash, 0, 30);

if (mash > 15)
    mashing = 1;
else
    mashing = 0;

if (!instance_exists(obj_samus_visual_mask))
{
    poop = 0;
    
    repeat (9)
    {
        instance_create(x, y, obj_samus_visual_mask);
        poop += 1;
    }
}

pos = 0;

if (!hurt)
{
    repeat (array_length(blacklist))
    {
        blacklist[pos][1] -= 1;
        
        if (blacklist[pos][1] <= 0)
            array_delete(blacklist, pos, 1);
        else
            pos += 1;
    }
}

if (ball)
    aim_lock_engaged = 0;

multiplier = lerp(multiplier, 1, 0.037037037037037035);

if (!place_meeting(x, y, par_solid))
{
    clip_x = x;
    clip_y = y;
    clip_dir = point_direction(x, y, global.xview + (global.wview / 2), global.yview + (global.hview / 4) + irandom(global.hview / 7));
    clip_time = 0;
}
else if (!spidering && !pose && !place_meeting(x, y, [obj_enemy_stone_toad]))
{
    clip_time += 1;
}

if (clip_time > 12)
{
    x = clip_x;
    y = clip_y;
}

if (dz("Aqua-Recovery") && place_meeting(x, y, obj_water_0))
    aqua_recover += 1;
else
    aqua_recover = 0;

if (aqua_recover > aqua_recovery_rate)
{
    new_damage_number("+1", x, y - 5, 15561728, 1);
    ds_add("Energy", 1);
    aqua_recover = 0;
}

if (dz("Energy Generator") && i_frames <= 0)
    auto_recover += 1;
else
    auto_recover = 0;

if (auto_recover > auto_recovery_rate)
{
    new_damage_number("+1", x, y - 5, 15561728, 1);
    ds_add("Energy", 1);
    auto_recover = 0;
}

if (dz("Missile Generator") && i_frames <= 0)
    missile_recover += 1;
else
    missile_recover = 0;

if (missile_recover > missile_recovery_rate)
{
    if (dz("Missiles Max") > dz("Missiles"))
        new_damage_number("+1", x, y - 5, 77019, 1);
    
    ds_add("Missiles", 1);
    missile_recover = 0;
}

if (dz("Power Bomb Generator") && i_frames <= 0)
    pb_recover += 1;
else
    pb_recover = 0;

if (pb_recover > pb_recovery_rate)
{
    if (dz("Power Bombs Max") > dz("Power Bombs"))
        new_damage_number("+1", x, y - 5, 4177906, 1);
    
    ds_add("Power Bombs", 1);
    pb_recover = 0;
}

if (!on_ground() && yspeed > 0)
    fall_time += 1;

if (spidering && stuck_on_wall)
{
    xspeed = x - xprevious;
    yspeed = y - yprevious;
}
