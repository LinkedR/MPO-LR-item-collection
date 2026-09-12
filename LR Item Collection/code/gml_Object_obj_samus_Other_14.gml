if (gripping && !global.key_left && !global.key_right && yspeed <= 0 && !climbing && (global.key_down || global.key_aim_lock || global.key_free_aim || global.key_grapple))
{
    yspeed = 1.3333;
    no_grip = 12;
    gripping = 0;
    exit;
}

if (grappling)
{
    global.key_jump = 0;
    global.key_shoot = 0;
    global.key_shoot_hold = 0;
}

if (!dz("Phazon Suit"))
    phazon_beam = 0;

if (instance_exists(obj_grapple_mask))
    exit;

if (global.key_scan_pressed)
{
    instance_destroy(obj_scan_pulse);
    
    with (par_player)
        instance_create(other.x, other.y, obj_scan_pulse);
}

function unclip_try()
{
    if (climbing || pose)
        exit;
    
    repeat (256)
    {
        if (!place_meeting(x, y + 12, par_solid) && place_meeting(x, y, par_solid))
            y += 1;
        
        if (!place_meeting(x, y - 8, par_solid) && place_meeting(x, y, par_solid))
            y -= 1;
        
        if (!place_meeting(x + 8, y, par_solid) && place_meeting(x, y, par_solid))
            x += 1;
        
        if (!place_meeting(x - 8, y, par_solid) && place_meeting(x, y, par_solid))
            x -= 1;
        
        if (!place_meeting(x, y, par_solid))
            break;
    }
}

function bomb_scatter()
{
    if (dz("Morph Ball Bomb") != 1)
        exit;
    
    if (charge_counter > 45)
    {
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 4.9,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: -4.9,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            vspeed: 4.9,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            vspeed: -4.9,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 3.6,
            vspeed: 3.6,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: -3.6,
            vspeed: 3.6,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: -3.6,
            vspeed: -3.6,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 3.6,
            vspeed: -3.6,
            life: 62
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 2.7,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: -2.7,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            vspeed: 2.7,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            vspeed: -2.7,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 1.777,
            vspeed: 1.777,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: -1.777,
            vspeed: 1.777,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: -1.777,
            vspeed: -1.777,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 1.777,
            vspeed: -1.777,
            life: 29
        });
        instance_create(x, y, obj_bomb, 
        {
            hspeed: 0.01111111,
            life: 5
        });
    }
}

if (on_ground() || gripping)
    spin = 0;

spr_facing = facing;

if (climbing)
{
    climb_count += 1;
    old_y = y;
    
    if (climb_count > 45)
    {
        climbing = 0;
        x = climb_x;
        y = climb_y;
        exit;
    }
    
    no_grip = 12;
    spin = 0;
    xspeed = 0;
    yspeed = 0;
    
    repeat (3)
    {
        if (x < climb_x)
            x += 1;
        
        if (x > climb_x)
            x -= 1;
        
        repeat (1)
        {
            if (y > (climb_y - 12))
                y -= 1;
            
            repeat (4)
            {
                if (y < (climb_y - 12))
                    y += 1;
            }
        }
        
        if (x == climb_x && y == (climb_y - 12))
        {
            if (place_meeting(x, y, par_solid))
            {
                ball = 1;
                bomb_scatter();
                bitsound(sndSamusBall);
            }
            else
            {
                climbing = 0;
            }
        }
    }
    
    exit;
}
else
{
    climb_count = 0;
}

if (no_grip)
{
    gripping = 0;
}
else
{
    if (can_grip && !gripping && !ball && y > 32 && !walljump && yspeed >= 0 && !no_grip)
    {
        grip_input = 0;
        
        if ((place_meeting(x + 3, y, par_solid) && global.key_right) || (place_meeting(x - 3, y, par_solid) && global.key_left))
            grip_input = 1;
        
        if (!on_ground() && grip_input && yspeed >= 0 && place_meeting(x + (facing * 1), y, par_solid) && !place_meeting(x, grip_y, par_solid))
        {
            xspeed = 0;
            yspeed = 0;
            gripping = 1;
            bitsound(sndSamusDuck);
            spin = 0;
            grip_aiming = 0;
            exit;
        }
    }
    
    if (gripping)
    {
        spin = 0;
        grappling = 0;
        i_initiated_this_jump = 1;
        dubble_jumped = 0;
        xspeed = 0;
        yspeed = 0;
        
        if (recoil > 0 || global.key_up || global.key_down || global.key_shoot_hold || global.key_missile || global.key_free_aim || global.key_aim_lock)
            grip_aiming = 1;
        
        _grip_facing = sign(grip_x - x);
        
        if (_grip_facing == 0)
            _grip_facing = 1;
        
        facing = _grip_facing;
        spr_facing = _grip_facing;
        
        repeat (32)
        {
            if (!place_meeting(x + _grip_facing, y, par_solid))
                x += _grip_facing;
            else
                break;
        }
        
        if ((grip_y % 4) != 0)
            grip_y = round(grip_y / 4) * 4;
        
        y = grip_y;
        
        if (on_ground() || hurt)
        {
            repeat (8)
            {
                if (place_meeting(x, y, par_solid))
                    y -= 1;
            }
            
            gripping = 0;
            no_grip = 12;
            exit;
        }
        
        jumpoff = 0;
        
        if ((global.key_left && facing == 1) || (global.key_right && facing == -1))
            jumpoff = 1;
        
        if ((global.key_left && facing == -1) || (global.key_right && facing == 1))
            jumpoff = -1;
        
        if (global.key_jump && jumpoff)
        {
            xspeed = -1 * facing;
            yspeed = -jumpspeed;
            spin = 1;
            gripping = 0;
            no_grip = 12;
            exit;
        }
        else if (global.key_jump && jumpoff == 0)
        {
            xspeed = 0;
            yspeed = -jumpspeed;
            spin = 1;
            gripping = 0;
            no_grip = 12;
            exit;
        }
        
        if (global.key_down && !global.key_left && !global.key_right)
        {
            xspeed = 0;
            yspeed = 0;
            spin = 0;
            gripping = 0;
            no_grip = 12;
            exit;
        }
        
        climbup = 0;
        
        if ((global.key_left && facing == -1) || (global.key_right && facing == 1))
            climbup = 1;
        
        if (morph_grip && !ds_zero("Morph Ball"))
            climbup = 0;
        
        if ((global.key_left && facing == 1) || (global.key_right && facing == -1))
            climbup = 0;
        
        if (climbup && (global.key_jump || (global.key_left_tap && facing == -1) || (global.key_right_tap && facing == 1) || global.key_up_tap))
        {
            climbing = 1;
            gripping = 0;
            no_grip = 12;
            bitsound(sndSamusTurn);
        }
        
        if (!can_grip)
        {
            gripping = 0;
            no_grip = 12;
        }
        
        exit;
    }
}

function normal_jump(arg0 = jumpspeed)
{
    courtesy_jump = 0;
    dubble_jumped = 0;
    yspeed = -arg0;
    bitsound(sndSamusJump);
    
    if ((global.key_left || global.key_right) && !ball)
    {
        spin = 1;
        
        if (ds_zero("Screw Attack"))
            bitsound(snd_samus_screw_attack);
    }
}

if (global.key_jump && ((on_ground() || courtesy_jump) || (!dubble_jumped && dz("Space Jump Boots") == 1) || courtesy_jump))
    i_initiated_this_jump = 1;
else if (on_ground() && yspeed >= 0)
    i_initiated_this_jump = 0;

if (on_ground() || yspeed > 1 || walljump)
    side_dashed = 0;

if (dz("Side-Dash") && global.key_jump && !ball && !side_dashed && dubble_jumped && !on_ground() && yspeed <= 1)
{
    xspeed = -walkspeed * 2.69 * facing;
    yspeed = -2.1;
    spin = 1;
    
    repeat (11)
        spawn(obj_effect_steam);
    
    side_dashed = 1;
    side_counter = 69;
    just_grappled = 1;
    bitsound(sndSamusJumpSpace, 1.27, 1.27);
    exit;
}

if (!ball && global.key_jump && (!on_ground() && (place_meeting(x + 1, y, par_solid) || place_meeting(x - 1, y, global.block)) && (global.key_left || global.key_right) && yspeed > 0 && spin) && !place_meeting(x + (xspeed * 2), y, [obj_block_1, obj_block_2, obj_block_3, obj_block_4, obj_block_5, obj_block_6, obj_block_7, obj_block_8]) && !gripping && !climbing && i_frames <= 0)
{
    walljump = 13;
    gripping = 0;
    no_grip = 12;
    climbing = 0;
    dubble_jumped = 0;
    
    repeat (8)
        spawn(obj_effect_steam);
    
    bitsound(sndSamusLand, 0.69);
    
    if (!in_water)
        normal_jump(walljumpspeed);
    else
        normal_jump(0.042);
    
    if (place_meeting(x - 6, y, global.block))
    {
        xspeed = walkspeed;
        facing = 1;
    }
    else
    {
        xspeed = -walkspeed;
        facing = -1;
    }
    
    walljump_dir = sign(xspeed);
    walljump_yspeed = yspeed;
    exit;
}

if (global.key_jump && !ball && !on_ground() && !place_meeting(x, y + 1, par_solid) && !spin)
    spin = 1;

if (global.key_jump && !on_ground() && !ball && ds_zero("Space Jump Boots") == 1 && !dubble_jumped)
{
    yspeed = -spacejumpspeed;
    gripping = 0;
    no_grip = 12;
    i_initiated_this_jump = 1;
    // ----- LRedit : Infinite jump lock -----
    if (!dz("LRItems Spacier Jump"))
    {
        dubble_jumped = 1;
    }
    // ---------------------------------------
    
    if (!courtesy_jump)
    {
        audio_stop_sound(sndSamusJump);
        bitsound(sndSamusJumpSpace);
    }
    
    spin = 2;
    alarm[0] = 25;
}

if (global.key_jump && (on_ground() || courtesy_jump) && !ball && !gripping)
    normal_jump();

if (spin && !global.key_aim_lock && !on_ground() && !gripping && !climbing)
{
    if (global.key_left && ((InputCheck(UnknownEnum.Value_2) && InputDuration(UnknownEnum.Value_2) > 1) || (InputCheck(UnknownEnum.Value_6) && InputDuration(UnknownEnum.Value_6) > 1)))
        facing = -1;
    
    if (global.key_right && ((InputCheck(UnknownEnum.Value_3) && InputDuration(UnknownEnum.Value_3) > 1) || (InputCheck(UnknownEnum.Value_7) && InputDuration(UnknownEnum.Value_7) > 1)))
        facing = 1;
}

if (on_ground())
    dubble_jumped = 0;

// ----- LRedit : Flash Shifting multidirectional logic -----
if (lrstate.shifttap > 0)
{
    lrstate.shifttap--;
    
    if (lrstate.shifttap == 0)
    {
        lrstate.shift_available = 3;
        lrstate.last_side = -10;
    }
}

if (!rolling && !spidering && !ball)
{
    var t_performDash = false;
    var t_dir = -1;
    
    if (global.key_left_tap)
        t_dir = 180;
    
    if (global.key_right_tap)
        t_dir = 0;
    
    if (global.key_up_tap)
        t_dir = 90;
    
    if (global.key_down_tap)
        t_dir = 270;
    
    if (t_dir != -1)
    {
        if (lrstate.shifttap > 0)
        {
            if ((((lrstate.last_side == t_dir || lrstate.last_side == -1) && lrstate.shift_available > 0) && (((t_dir == 0 || t_dir == 180) && dz("LRItems Flash Shift")) || ((t_dir == 90 || t_dir == 270) && dz("LRItems Ascension Shift")))) && (!place_meeting(x, y, par_water) || dz("Gravity Suit")))
            {
                t_performDash = true;
                lrstate.shift_available--;
                crouch = 0;
                samus_masks();
            }
        }
        else
        {
            lrstate.shifttap = 15;
        }
        
        lrstate.last_side = t_dir;
    }
    
    if (t_performDash)
    {
        lrstate.shifttap = 30;
        lrstate.last_side = -1;
        var t_verStep = 8;
        var t_verDirection = t_dir;
        var t_step = walkdir * t_verStep;
        var t_maxShift = 80;
        var t_attempts = t_maxShift / t_verStep;
        var t_direction = "forth";
        var t_grounded = false;
        var t_playEffect = 0;
        var t_imageAt = 0;
        var t_axis = (t_dir == 0 || t_dir == 180) ? 0 : 1;
        yspeed = 0;
        bitsound(sndSamusJump);
        
        repeat (t_attempts)
        {
            if (t_playEffect <= 0)
            {
                t_playEffect = 2;
                
                if (!ball)
                {
                    if (walkdir == 1)
                        sprite_index = s_run_r;
                    else
                        sprite_index = s_run_l;
                    
                    image_index = t_imageAt;
                    t_imageAt++;
                }
                
                instance_create(x, y, obj_samus_trail);
            }
            
            t_playEffect--;
            
            if (t_axis == 0 && on_ground())
                t_grounded = true;
            
            x += lengthdir_x(t_verStep, t_verDirection);
            y += lengthdir_y(t_verStep, t_verDirection);
            t_direction = "forth";
            
            if (t_axis == 0)
            {
                if (t_grounded && !on_ground())
                {
                    y += t_verStep;
                    
                    if (place_meeting(x, y, par_solid))
                    {
                        t_direction = "descended";
                        
                        repeat (t_verStep)
                        {
                            if (!place_meeting(x, y, par_solid))
                                break;
                            
                            y--;
                        }
                    }
                    else
                    {
                        y -= t_verStep;
                    }
                }
                
                if (t_direction == "forth" && place_meeting(x, y, par_solid))
                {
                    y -= t_verStep;
                    
                    if (place_meeting(x, y, par_solid))
                    {
                        y += t_verStep;
                        break;
                    }
                    else
                    {
                        t_direction = "ascended";
                        
                        repeat (t_verStep)
                        {
                            if (on_ground())
                                break;
                            
                            y++;
                        }
                    }
                }
            }
            else if (place_meeting(x, y, par_solid))
            {
                break;
            }
        }
        
        if (t_direction == "forth")
        {
            repeat (t_verStep)
            {
                x += lengthdir_x(-1, t_verDirection);
                y += lengthdir_y(-1, t_verDirection);
                
                if (!place_meeting(x, y, par_solid))
                    break;
            }
        }
        
        x = clamp(x, 16, room_width - 16);
        y = clamp(y, 16, room_height - 16);
    }
}
// ---------------------------------------------------------

if (on_ground() && prev_air && !spidering && !stuck_on_wall)
{
    prev_air = 0;
    vibrate(0.42, 5);
    
    if (ball && (yspeed >= 3.3 || bouncing) && !global.key_aim_lock && !global.key_free_aim)
    {
        bouncing = 1;
        bitsound(sndSamusTurn, 1.42);
        yspeed = -yspeed / 2.7;
        
        if (abs(yspeed) < 1.1)
            bouncing = 0;
    }
    else
    {
        bouncing = 0;
    }
    
    audio_stop_sound(sndSamusJumpSpace);
    audio_stop_sound(sndSamusSpaceLoop);
    audio_stop_sound(sndSamusScrewLoop);
    audio_stop_sound(sndSamusScrew);
    audio_stop_sound(snd_samus_screw_attack);
    just_grappled = 0;
    bitsound(sndSamusLand);
}

if (!on_ground())
    prev_air = 1;

if (global.key_jump && ball && ds_zero("Morph Ball Bomb") == 1 && on_ground() && !spidering)
{
    normal_jump(jumpballspeed);
    exit;
}

if (!global.key_jump_hold && yspeed < 0 && !just_grappled && !ball && !(missile_recoil && yspeed > -2) && i_initiated_this_jump && !place_meeting(x, y, obj_fountain_acid) && !place_meeting(x, y, obj_fountain_water))
    yspeed *= 0.7777777777777778;

function find_cannon_angle()
{
    if (grappling || global.key_grapple)
        exit;
    
    old_cannon_angle = cannon_angle;
    
    if (global.key_aim_lock)
    {
        if (!aim_lock_engaged)
        {
            lock_facing = facing;
            lock_spr_facing = spr_facing;
        }
        
        aim_lock_engaged = 1;
        turn = 0;
        aiming = 60;
        spin = 0;
        alarm[2] = 1;
    }
    
    if (global.key_free_aim)
        turn = 0;
    
    if (!global.key_aim_lock && aim_lenience == 0)
    {
        var _aim_cluster = global.key_free_aim ? UnknownEnum.Value_4 : UnknownEnum.Value_2;
        
        if (!global.mouse_on && !ds_zero_options("Dual Stick") && ((InputCheck(UnknownEnum.Value_0) && InputDuration(UnknownEnum.Value_0) > 1) || (InputCheck(UnknownEnum.Value_1) && InputDuration(UnknownEnum.Value_1) > 1) || (InputCheck(UnknownEnum.Value_2) && InputDuration(UnknownEnum.Value_2) > 1) || (InputCheck(UnknownEnum.Value_3) && InputDuration(UnknownEnum.Value_3) > 1) || (InputCheck(UnknownEnum.Value_4) && InputDuration(UnknownEnum.Value_4) > 1) || (InputCheck(UnknownEnum.Value_5) && InputDuration(UnknownEnum.Value_5) > 1) || (InputCheck(UnknownEnum.Value_6) && InputDuration(UnknownEnum.Value_6) > 1) || (InputCheck(UnknownEnum.Value_7) && InputDuration(UnknownEnum.Value_7) > 1)))
            cannon_angle = InputDirection(cannon_angle, _aim_cluster, player);
        
        if (ds_zero_options("Dual Stick"))
            cannon_angle = InputDirection(cannon_angle, UnknownEnum.Value_0, player);
        
        if (instance_exists(obj_boss_metroid_prime))
        {
            if (obj_boss_metroid_prime.cam_ang != 0 && !ds_zero_options("Dual Stick"))
                cannon_angle = InputDirection(cannon_angle, UnknownEnum.Value_3, player);
            
            if (obj_boss_metroid_prime.cam_ang != 0 && ds_zero_options("Dual Stick"))
                cannon_angle = InputDirection(cannon_angle, UnknownEnum.Value_1, player);
        }
        
        if (global.key_free_aim_released)
            aim_lenience = 16;
        
        if (facing == 1 && !global.key_left && !global.key_right && !global.key_up && !global.key_down && !global.key_free_aim && !global.mouse_on && !global.key_beam_0 && !global.key_beam_1 && !global.key_beam_2 && !global.key_beam_3)
            cannon_angle = 0;
        
        if (facing == -1 && !global.key_left && !global.key_right && !global.key_up && !global.key_down && !global.key_free_aim && !global.mouse_on && !global.key_beam_0 && !global.key_beam_1 && !global.key_beam_2 && !global.key_beam_3)
            cannon_angle = 180;
        
        if (global.mouse_on)
            cannon_angle = point_direction(x - global.xview, y - global.yview, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) - 8);
        
        if (global.mouse_on)
            turn = 0;
        
        if (can_ang != 0 && can_ang != 180)
            aiming = 1;
        
        if (global.key_free_aim)
        {
            spin = 0;
            aiming = 1;
            gripping = 0;
            no_grip = 12;
            alarm[2] = 20;
        }
    }
    
    if (cannon_angle > 102 && cannon_angle < 258)
        spr_facing = -1;
    
    if (cannon_angle < 78 || cannon_angle > 282)
        spr_facing = 1;
    
    if (crouch == 1 && on_ground() && !global.key_free_aim && cannon_angle > 180 && !global.mouse_on)
    {
        if (facing == 1)
            cannon_angle = 0;
        else
            cannon_angle = 180;
    }
    
    if (global.retro_mode)
    {
        cannon_angle = round(cannon_angle / 90) * 90;
        
        if (global.key_up && (!crouch || global.key_free_aim))
            cannon_angle = 90;
        
        if (global.key_down && (!crouch || global.key_free_aim))
            cannon_angle = 270;
    }
    
    can_ang = round(cannon_angle / 22.5) * 22.5;
    
    if (can_ang == 0)
        cannon_frame = 4;
    
    if (can_ang == 22.5)
        cannon_frame = 3;
    
    if (can_ang == 45)
        cannon_frame = 2;
    
    if (can_ang == 67.5)
        cannon_frame = 1;
    
    if (can_ang == 90)
        cannon_frame = 0;
    
    if (can_ang == 112.5)
        cannon_frame = 1;
    
    if (can_ang == 135)
        cannon_frame = 2;
    
    if (can_ang == 157.5)
        cannon_frame = 3;
    
    if (can_ang == 180)
        cannon_frame = 4;
    
    if (can_ang == 202.5)
        cannon_frame = 5;
    
    if (can_ang == 225)
        cannon_frame = 6;
    
    if (can_ang == 247.5)
        cannon_frame = 7;
    
    if (can_ang == 270)
        cannon_frame = 8;
    
    if (can_ang == 292.5)
        cannon_frame = 7;
    
    if (can_ang == 315)
        cannon_frame = 6;
    
    if (can_ang == 337.5)
        cannon_frame = 5;
    
    if (can_ang == 360)
        cannon_frame = 4;
    
    if (aim_lock > 0 && !ds_zero_options("Lock-On"))
    {
        cannon_frame = 0;
        
        if (facing == 1)
            cannon_angle = 0;
        else
            cannon_angle = 180;
    }
    
    if (old_cannon_angle != cannon_angle)
        vibrate(0.012, 4);
}

function shoot_beam(arg0 = 0)
{
    if (grappling || crouch > 1 || gripping)
        exit;
    
    if (global.retro_mode && dz("Charge Beam"))
    {
        charge_counter = 0;
        charged = 0;
    }
    
    vibrate(0.21, 10);
    spin = 0;
    
    if (arg0 == 0)
        lastused_missile = 0;
    else
        lastused_missile = 420;
    
    beam_queue = 0;
    recoil = 10;
    beam_object = obj_beam_power_0;
    aiming = 1;
    alarm[2] = 60;
    
    // ----- LRedit : beam switching rework -----
    switch (dz("Beam"))
    {
        case 0:
            if (dz("LRItems Nova Beam"))
                recoil = 5;
            else
                recoil = 10;
            
            beam_object = LRobj_beam_power;
            break;
        
        case 1:
            if (dz("LRItems Annihilating Wave"))
                recoil = 9;
            else
                recoil = 15;
            
            beam_object = LRobj_beam_wave;
            break;
        
        case 2:
            recoil = 25;
            beam_object = LRobj_beam_ice;
            break;
        
        case 3:
            recoil = 20;
            beam_object = LRobj_beam_plasma;
            break;
    }
    
    if (phazon_beam > 0 && arg0 == 0)
    {
        recoil = 6;
        
        if (!dz("LRItems Phazon Overload"))
            beam_object = obj_beam_phazon_0;
        else
            beam_object = LRobj_beam_phazon;
        
        phazon_beam -= 1;
    }
    // -------------------------------------------
    
    if (arg0 == 1 && ds_zero("Missiles") > 0)
    {
        if (dz("Chain Missile"))
            missile_recoil = 21;
        else
            missile_recoil = 30;
        
        if (!on_ground())
            yspeed = lengthdir_y(1.1111, cannon_angle + 180);
        
        beam_object = obj_missile_0;
        ds_add("Missiles", -1);
        
        if (ds_zero("Super Missile"))
            beam_object = obj_missile_1;
    }
    else if (arg0 == 1)
    {
        recoil = 12;
        beam_object = obj_nothing;
        bitsound(sndSamusAim);
    }
    
    if (arg0 == 2 && ds_zero("Missiles") >= 10)
    {
        recoil = 21;
        ds_add("Missiles", -10);
        
        if (ds_zero("Beam") == 0)
            beam_object = obj_combo_power;
        
        if (ds_zero("Beam") == 1)
            beam_object = obj_combo_wave;
        
        if (ds_zero("Beam") == 2)
            beam_object = obj_combo_ice;
        
        if (ds_zero("Beam") == 3)
            beam_object = obj_combo_plasma;
    }
    
    if (!dz("Power Beam") && (beam_object == obj_beam_power_0 || beam_object == obj_beam_power_1))
    {
        bitsound(sndSamusAim);
        beam_object = obj_nothing;
    }
    
    if (dz("Gatling Beam"))
        recoil = ceil(recoil * 0.8);
    
    instance_create(x, y, beam_object);
    
    if (phazon_beam > 0)
        exit;
    
    if (missile == 0 && beam_object == obj_beam_power_1)
    {
        repeat (2)
        {
            spazer_id += 1;
            instance_create(x, y, beam_object);
        }
    }
    
    if (beam_charged)
    {
        beam_queue = 0;
        mashing = 0;
    }
    
    spazer_id = 0;
    charge_counter = 0;
    beam_charged = 0;
}

if (dz("Boost-Sprint") && on_ground() && ball && boosting && (global.key_ball || InputBufferPressed(UnknownEnum.Value_0, 12)) && !sprinting)
{
    bitsound(snd_poof_3);
    sprinting = 1;
}

if (abs(xspeed) < 1.69 && !global.key_left && !global.key_right)
    sprinting = 0;

if (!gripping)
    find_cannon_angle();

if (global.key_shoot && !ball && recoil > 0 && charge_counter < 5 && !dz("Charge Beam"))
    beam_queue = 1;

if ((!dz("Charge Beam") && !ball) || (global.retro_mode && !ball))
    global.key_shoot = global.key_shoot_hold;

if (ds_zero_options("Auto Charge") && dz("Charge Beam"))
{
    if (!global.key_missile)
        global.key_shoot_hold = !global.key_shoot;
}

if (global.key_shoot && dz("Charge Beam"))
    mash += 16;

if ((((global.key_shoot || mashing) && !ball && recoil == 0) || ((beam_queue > 0 && !global.key_shoot_hold) && recoil == 0)) && !missile_recoil)
{
    if (!dz("Charge Beam"))
        mash = 0;
    
    if (!just_shot_a_charge_shot)
        shoot_beam(0);
    
    just_shot_a_charge_shot = 0;
    exit;
}

if (global.key_missile && !missile_recoil && !ball && (!beam_charged || !global.key_shoot_hold))
    shoot_beam(1);

if (global.key_missile && global.key_shoot_hold && !ball && recoil == 0 && beam_charged && ds_zero("Super Missile") == 1 && !missile_recoil)
    shoot_beam(2);

if (!global.key_shoot_hold && !ball && recoil == 0 && charge_counter > 15 && !missile_recoil && !missile_recoil)
{
    if (!just_shot_a_charge_shot)
        shoot_beam(0);
    
    just_shot_a_charge_shot = 0;
}

if (global.key_shoot_hold && phazon_beam > 0 && !ball && recoil == 0 && !missile_recoil)
{
    shoot_beam(0);
    phazon_beam -= 1;
}

if (!(global.key_shoot_hold && phazon_beam <= 0 && !ball && !grappling && !instance_exists(obj_grapple_mask)))
{
    beam_charged = 0;
    charge_counter = 0;
}

if (ds_zero("Beam") == 0)
{
    charge_sfx = sndBeamChargingPower;
    charge_loop = sndBeamChargingPowerLoop;
    charge_orb = sprPowerCharge_strip4;
    charge_max = 37;
}

if (ds_zero("Beam") == 1)
{
    charge_sfx = sndBeamChargingWave;
    charge_loop = sndBeamChargingWaveLoop;
    charge_orb = sprWaveCharge_strip6;
    charge_max = 52;
}

if (ds_zero("Beam") == 2)
{
    charge_sfx = sndBeamChargingIce;
    charge_loop = sndBeamChargingIceLoop;
    charge_orb = sprIceCharge_strip6;
    charge_max = 66;
}

if (ds_zero("Beam") == 3)
{
    charge_sfx = sndBeamChargingPlasma;
    charge_loop = sndBeamChargingPlasmaLoop;
    charge_orb = sprFlameCharge_strip6;
    charge_max = 82;
}

if (dz("Charge Module"))
{
    charge_max /= 2;
    charge_max = round(charge_max);
}

if ((ds_zero("Charge Beam") && global.key_shoot_hold) && recoil == 0 && phazon_beam <= 0 && !ball && !grappling && !instance_exists(obj_grapple_mask))
{
    aiming = 1;
    
    if (charge_counter > 5)
        beam_queue = 0;
    
    alarm[2] = 30;
    
    if ((charge_counter % 5) == 0 && charge_counter < charge_max)
        vibrate(0.1, 10);
    
    if (recoil == 0)
        charge_counter += 1;
    
    if (charge_counter > charge_max)
    {
        vibrate(0.55, 1);
        beam_charged = 1;
    }
    
    if (global.retro_mode)
    {
        charge_counter = 0;
        charged = 0;
    }
    
    if (charge_counter == 5)
        bitsound(charge_sfx);
    
    if (charge_counter > 10 && !audio_is_playing(charge_sfx) && !audio_is_playing(charge_loop))
        bitsound(charge_loop);
}
else
{
    audio_stop_sound(charge_sfx);
    audio_stop_sound(charge_loop);
}

if (!rolling && place_meeting(x, y + (yspeed * 2), par_quarter_pipe) && yspeed > 2 && ball)
{
    ball_dir = 1;
    
    with (instance_nearest(x, y, par_quarter_pipe))
        other.ball_dir = image_xscale;
    
    repeat (8)
    {
        if (!place_meeting(x, y + 1, par_solid))
            y += 1;
    }
    
    yspeed = 0;
    facing = ball_dir;
    rolling = 12;
    
    if (boost_dir == 1)
        boost_dir = 0;
}

if (rolling > 0 && ball && on_ground())
{
    boost_residue = 0;
    xspeed = boost_speed * ball_dir;
    rolling -= 1;
    
    if (rolling == 0 && !boosting)
        xspeed = ball_dir;
}
else
{
    rolling = 0;
}

if (ds_zero("Boost Ball") && ball)
{
    if (global.key_free_aim_pressed)
        boost_counter = 0;
    
    if (global.key_free_aim && !spidering)
    {
        if ((boost_counter % 30) == 0)
            vibrate_pulse(0.25, 30, 2);
        
        if (boost_counter == 0 && !audio_is_playing(sndSamusBoostBallCharge) && !audio_is_playing(sndSamusBoostBallChargeLoop))
            bitsound(sndSamusBoostBallCharge);
        
        if (!audio_is_playing(sndSamusBoostBallCharge) && !audio_is_playing(sndSamusBoostBallChargeLoop))
            bitsound(sndSamusBoostBallChargeLoop);
        
        boost_max = og_boost_max;
        
        if (dz("Boost Extender"))
            boost_max = ceil(boost_max * 2.1);
        
        repeatme = 1;
        
        if (dz("Boost Charger"))
            repeatme = 2;
        
        repeat (repeatme)
        {
            if (boost_counter < boost_max)
                boost_counter += 1;
        }
    }
    
    if (!global.key_free_aim || spidering)
    {
        audio_stop_sound(sndSamusBoostBallCharge);
        audio_stop_sound(sndSamusBoostBallChargeLoop);
        
        if (boost_counter > 0)
            boost_counter -= 1;
    }
    
    if (!global.key_free_aim && boost_counter > boost_min)
    {
        if (boost_counter > boost_min)
            boosting = boost_counter;
    }
    
    if (boosting > 0)
    {
        if (boosting == boost_counter && !global.key_free_aim)
        {
            boost_factor = 0.5 + ((boost_counter / boost_max) * 0.47);
            bitsound(sndSamusBoostBall);
            
            if (on_ground() || place_meeting(x, y - 4, par_solid) || place_meeting(x, y + 4, par_solid))
            {
                boost_dir = 0;
                xspeed = boost_speed * 1.7 * facing * boost_factor;
            }
            else
            {
                boost_dir = 1;
                yspeed = boost_speed;
            }
        }
        
        boost_counter = 0;
        xspeed *= 0.98;
        
        if (abs(xspeed) < 2)
            boosting -= 1;
        
        boost_residue = 30;
        
        if (boost_dir == 1)
            xspeed = 0;
        
        if (place_meeting(x + xspeed, y, par_solid) && boosting > 0)
            boosting -= 1;
    }
    else
    {
        quarter_piping = 0;
    }
    
    if (boosting > 0 || abs(xspeed) > (walkspeed + 1))
    {
        if (!quarter_piping && (on_ground() || (place_meeting(x, y - 2, par_solid) && !boost_dir)))
        {
            xspeed = lerp(xspeed, facing * boost_speed * boost_factor, 0.042);
            
            if (place_meeting(x, y + 2, par_quarter_pipe) && place_meeting(x + xspeed, y, par_solid) && !place_meeting(x + xspeed, y, par_quarter_pipe) && !in_water)
            {
                quarter_piping = 1;
                boosting *= 2.7;
                boosting += 33;
                boosting = clamp(boosting, 69, 201);
            }
        }
        
        if (quarter_piping)
        {
            xspeed = (-global.key_left * 0.5) + (global.key_right * 0.5);
            yspeed = -boost_speed;
        }
    }
}

if (!ball)
{
    audio_stop_sound(sndSamusBoostBallCharge);
    audio_stop_sound(sndSamusBoostBallChargeLoop);
    boosting = 0;
    boost_counter = 0;
}

function shoot_grapple()
{
    if (!global.key_grapple_pressed)
        exit;
    
    beam_queue = 0;
    recoil = 10;
    aiming = 1;
    alarm[2] = 100;
    started = 0;
    grapple_counter = 0;
    vibrate(0.21, 16);
    charge_counter = 0;
    beam_charged = 0;
    grap = 0;
    bitsound(snd_samus_grapple_beam);
    crouch = 0;
    spin = 0;
    grappling = 0;
    samus_masks();
    
    if (place_meeting(x, y, par_solid))
    {
        crouch = 1;
        samus_masks();
        exit;
    }
    
    instance_create(x + charge_x, y + charge_y, obj_grapple_mask);
}

function grapple_swing()
{
    if (!audio_is_playing(snd_samus_grapple_loop))
        bitsound(snd_samus_grapple_loop);
    
    dubble_jumped = 0;
    
    if (!place_meeting(x, y, par_solid))
    {
        grap_xprev = x;
        grap_yprev = y;
    }
    
    grapple_counter += (1 * grapple_reverse);
    
    if (grapple_counter == 1 && !started)
    {
        started = 1;
        grapple_angle = point_direction(grapple_x, grapple_y, x, y);
        grapple_length = point_distance(grapple_x, grapple_y, x, y);
        grapple_speed = 0;
        grapple_velocity = 0;
        grapple_reverse = 1;
    }
    
    grapple_speed = (-0.02 * global.key_left) + (0.02 * global.key_right);
    grapple_length += ((2 * global.key_down * !place_meeting(x, y + 4, par_solid)) - (2 * global.key_up * !place_meeting(x, y - 4, par_solid)));
    grapple_speed = clamp(grapple_speed, -7, 7);
    grapple_length = clamp(grapple_length, 2, 128);
    grapple_acc = -0.1 * dcos(grapple_angle);
    grapple_acc += grapple_speed;
    grapple_velocity += grapple_acc;
    grapple_velocity = clamp(grapple_velocity, -4.2, 4.2);
    
    if (place_meeting(x + 1, y, par_solid))
        grapple_velocity = abs(grapple_velocity) * -1;
    
    if (place_meeting(x - 1, y, par_solid))
        grapple_velocity = abs(grapple_velocity) * 1;
    
    grapple_angle += grapple_velocity;
    xspeed = (grapple_x + lengthdir_x(grapple_length, grapple_angle)) - x;
    yspeed = (grapple_y + lengthdir_y(grapple_length, grapple_angle)) - y;
    xspeed = clamp(xspeed, -6.9, 6.9);
    yspeed = clamp(yspeed, -6.9, 6.9);
    move_snap(1, 1);
    
    if (place_meeting(x, y, par_solid))
    {
        x = grap_xprev;
        y = grap_yprev;
    }
    
    if (!global.key_grapple && !place_meeting(x, y, par_solid))
    {
        yspeed = -2.7;
        just_grappled = 1;
        spin = 1;
        aiming = 0;
        move_snap(1, 1);
        grappling = 0;
    }
}

function grapple_hookshot()
{
    if (!audio_is_playing(snd_samus_grapple_loop))
        bitsound(snd_samus_grapple_loop);
    
    dubble_jumped = 0;
    
    if (!place_meeting(x, y, [par_solid, obj_enemy_glider, par_spikes]))
    {
        grap_xprev = x;
        grap_yprev = y;
    }
    
    grapple_counter += 1;
    grapple_angle = point_direction(x, y, grapple_x, grapple_y);
    xspeed = lengthdir_x(6, grapple_angle);
    yspeed = lengthdir_y(6, grapple_angle);
    
    if (position_meeting(x + (xspeed * 7), y + (yspeed * 7), [par_spikes, obj_enemy_glider]))
        frozen_grapple = 1;
    else
        frozen_grapple = 0;
    
    if (!global.key_grapple)
    {
        grappling = 0;
        just_grappled = 1;
        spin = 1;
    }
}

if ((global.key_grapple && grappling) || (grappling && place_meeting(x, y, [par_solid, obj_enemy_glider]) && !ball))
{
    if (grappling == 1)
        grapple_swing();
    
    if (grappling == 2)
        grapple_hookshot();
    
    exit;
}
else
{
    frozen_grapple = 0;
    grapple_reverse = 1;
    audio_stop_sound(snd_samus_grapple_loop);
    grapple_speed = 0;
}

if (can_grapple == 0 && global.key_grapple && !grappling && !instance_exists(obj_grapple_mask) && !ball && ds_zero("Grapple Beam"))
    shoot_grapple();

if (!global.key_grapple && grappling && !place_meeting(x, y, par_solid))
{
    vibrate(0.69, 9);
    grappling = 0;
    grapple = 0;
    spin = 1;
    xspeed = (cos(grap / 27) * facing * grapple_radius) / 32;
    grapple_fling_limit = 4.7;
    
    if (abs(xspeed) > grapple_fling_limit)
        xspeed = sign(xspeed) * grapple_fling_limit;
    
    if (!global.key_down)
        yspeed = -spacejumpspeed / 2.42;
    else
        yspeed = 0.5;
    
    grap = 0;
    just_grappled = 1;
}

reticle_lerp = reticle_angle + angle_difference(cannon_angle, reticle_angle);
reticle_angle = lerp(reticle_angle, reticle_lerp, 0.5);

if (global.key_free_aim && !ball)
{
    reticle_distance += 16;
    instance_create(x, y, obj_reticle_0);
}

if (global.key_aim_lock && !ball)
{
    reticle_distance += 16;
    instance_create(x, y, obj_reticle_1);
}

if (!global.key_free_aim && !global.key_aim_lock)
{
    reticle_distance = 0;
    reticle_angle = cannon_angle;
}

if (reticle_distance > 256)
    reticle_distance = 256;

if ((global.key_left || global.key_right) && !rolling && !crouch && !spidering && (!global.key_free_aim || ball))
{
    if (global.key_left)
        walkdir = -1;
    
    if (global.key_right)
        walkdir = 1;
    
    if (walkdir == 1 && xspeed < walkspeed)
        xspeed += (walk_accel * walkdir);
    
    if (walkdir == -1 && xspeed > -walkspeed)
        xspeed += (walk_accel * walkdir);
}
else if (boost_residue == 0)
{
    if (on_ground() || (!just_grappled && !spin && !boosting))
        xspeed *= walk_deccel;
}

if ((abs(xspeed) > walkspeed && yspeed >= 0 && !boosting && !rolling) || (boost_residue > 0 && !boosting && !rolling))
    xspeed *= 0.99;

if (xspeed > 0 && facing == -1 && !global.key_aim_lock)
    xspeed *= walk_deccel;

if (xspeed < 0 && facing == 1 && !global.key_aim_lock)
    xspeed *= walk_deccel;

if (global.key_left && !ball && turn == 0 && !just_grappled && InputCheck(UnknownEnum.Value_2) && InputDuration(UnknownEnum.Value_2) > 1)
{
    if (facing != -1)
    {
        aim_lenience = 0;
        
        if (!global.key_aim_lock)
        {
            facing = -1;
            
            if (crouch == 0)
                turn = 5;
            
            exit;
        }
    }
}

if (global.key_right && !ball && turn == 0 && !just_grappled && InputCheck(UnknownEnum.Value_3) && InputDuration(UnknownEnum.Value_3) > 1)
{
    if (facing != 1)
    {
        aim_lenience = 0;
        
        if (!global.key_aim_lock)
        {
            facing = 1;
            
            if (crouch == 0)
                turn = 5;
            
            exit;
        }
    }
}

if (global.key_left && ball && ((InputCheck(UnknownEnum.Value_6) && InputDuration(UnknownEnum.Value_6) > 1) || (InputCheck(UnknownEnum.Value_2) && InputDuration(UnknownEnum.Value_2) > 1)))
    facing = -1;

if (global.key_right && ball && ((InputCheck(UnknownEnum.Value_7) && InputDuration(UnknownEnum.Value_7) > 1) || (InputCheck(UnknownEnum.Value_3) && InputDuration(UnknownEnum.Value_3) > 1)))
    facing = 1;

if (ds_zero("Spider Ball") == 1 && ball)
{
    if (in_water)
    {
        spider_charge = 0;
        spidering = 0;
    }
    
    if (global.key_aim_lock)
    {
        if ((spider_charge % 45) == 0)
            vibrate_pulse(0.32, 45, 3);
        
        spider_charge += 1;
    }
    else
    {
        flippied = 0;
        spider_charge = 0;
    }
    
    if (spider_charge == 3)
    {
        multiplier = 1;
        
        if (boosting)
            multiplier = boost_factor * 11;
        
        multiplier = clamp(multiplier, 1, 12.21);
    }
    
    if (multiplier > 1.1 && global.key_aim_lock)
        spider_charge += 7;
    
    _thing = instance_nearest(x, y, par_door_cover);
    
    if (instance_exists(_thing))
    {
        if (distance_to_point(_thing.x, _thing.y) < 32)
            multiplier = 1;
    }
    
    if (spider_charge > 3)
    {
        if (spidering == 0)
        {
            spidering = 1;
            
            repeat (3)
            {
                if (place_meeting(x + 4, y, global.block) && !place_meeting(x + 1, y, global.block))
                    x += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x - 4, y, global.block) && !place_meeting(x - 1, y, global.block))
                    x -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y + 4, global.block) && !place_meeting(x, y + 1, global.block))
                    y += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y - 4, global.block) && !place_meeting(x, y - 1, global.block))
                    y -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x + 3, y, global.block) && !place_meeting(x + 1, y, global.block))
                    x += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x - 3, y, global.block) && !place_meeting(x - 1, y, global.block))
                    x -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y + 3, global.block) && !place_meeting(x, y + 1, global.block))
                    y += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y - 3, global.block) && !place_meeting(x, y - 1, global.block))
                    y -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x + 2, y, global.block) && !place_meeting(x + 1, y, global.block))
                    x += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x - 2, y, global.block) && !place_meeting(x - 1, y, global.block))
                    x -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y + 2, global.block) && !place_meeting(x, y + 1, global.block))
                    y += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y - 2, global.block) && !place_meeting(x, y - 1, global.block))
                    y -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x + 1, y, global.block) && !place_meeting(x + 1, y, global.block))
                    x += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x - 1, y, global.block) && !place_meeting(x - 1, y, global.block))
                    x -= 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y + 1, global.block) && !place_meeting(x, y + 1, global.block))
                    y += 1;
            }
            
            repeat (3)
            {
                if (place_meeting(x, y - 1, global.block) && !place_meeting(x, y - 1, global.block))
                    y -= 1;
            }
        }
    }
    else
    {
        spidering = 0;
    }
    
    function geem_around(arg0)
    {
        var b = true;
        
        if (place_meeting(x + lengthdir_x(sign(arg0), dir), y + lengthdir_y(sign(arg0), dir), global.block))
        {
            dir = (dir + (sign(arg0) * 90)) % 360;
            b = false;
        }
        else if (fpixel <= 0 && !place_meeting(x + dcos(dir - 90), y - dsin(dir - 90), global.block))
        {
            dir = (dir - (sign(arg0) * 90)) % 360;
            fpixel = 1;
        }
        
        if (b)
        {
            x += lengthdir_x(arg0, dir);
            y += lengthdir_y(arg0, dir);
            fpixel -= abs(arg0);
        }
        
        var vx = lengthdir_x(0.5, dir - 90);
        var vy = lengthdir_y(0.5, dir - 90);
        
        if (!place_meeting(x + vx, y + 0, global.block))
            x += vx;
        
        if (!place_meeting(x + 0, y + vy, global.block))
            y += vy;
    }
    
    if (!place_meeting(x - 2, y, global.block) && !place_meeting(x + 2, y, global.block) && !place_meeting(x, y - 2, global.block) && !place_meeting(x, y + 2, global.block) && !place_meeting(x - 2, y + 2, global.block) && !place_meeting(x - 2, y - 2, global.block) && !place_meeting(x + 2, y - 2, global.block) && !place_meeting(x + 2, y + 2, global.block))
    {
        spidering = 0;
        spider_dir = 0;
    }
    
    if (spidering)
    {
        if (!audio_is_playing(snd_samus_spider_ball_loop))
            bitsound(snd_samus_spider_ball_loop, 1.27);
        
        xspeed = 0;
        yspeed = 0;
        mask_index = sprSamusBallMask;
        
        if (multiplier < 3)
        {
            boosting = 0;
            boost_counter = 0;
        }
        
        if (place_meeting(x - 2, y, global.block) || place_meeting(x, y + 2, global.block))
        {
            stuck_on_wall = 1;
            
            if (spider_dir == 0)
            {
                if (global.key_up)
                    spider_dir = -1;
                
                if (global.key_down)
                    spider_dir = 1;
                
                if (global.key_left)
                    spider_dir = -1;
                
                if (global.key_right)
                    spider_dir = 1;
            }
        }
        else if (place_meeting(x + 2, y, global.block) || place_meeting(x, y - 2, global.block))
        {
            stuck_on_wall = 1;
            
            if (spider_dir == 0)
            {
                if (global.key_up)
                    spider_dir = 1;
                
                if (global.key_down)
                    spider_dir = -1;
                
                if (global.key_left)
                    spider_dir = 1;
                
                if (global.key_right)
                    spider_dir = -1;
                
                if (place_meeting(x, y - 2, global.block) && (global.key_left || global.key_right) && !just_stuck)
                {
                    spider_dir *= -1;
                    just_stuck = 1;
                }
            }
        }
        else
        {
            just_stuck = 0;
            stuck_on_wall = 0;
        }
        
        if (!(!global.key_left && !global.key_right && !global.key_up && !global.key_down))
        {
            repeat (floor(multiplier))
                geem_around(spider_dir);
        }
    }
    else
    {
        spider_dir = 0;
        move_snap(1, 1);
        var the_last_y = y;
        
        repeat (12)
        {
            if (place_meeting(x, y, par_solid))
                y -= 1;
        }
        
        if (place_meeting(x, y, par_solid))
            y = the_last_y;
    }
    
    if (!global.key_left && !global.key_right && !global.key_up && !global.key_down)
        spider_dir = 0;
    
    if (!global.key_aim_lock)
        audio_stop_sound(snd_samus_spider_ball_loop);
}
else
{
    stuck_on_wall = 0;
    spidering = 0;
}

if (!ball)
    audio_stop_sound(snd_samus_spider_ball_loop);

__dir = InputDirection(cannon_angle, UnknownEnum.Value_2, 0);

if ((InputCheck(UnknownEnum.Value_4) && InputDuration(UnknownEnum.Value_4) > 1) || (InputCheck(UnknownEnum.Value_5) && InputDuration(UnknownEnum.Value_5) > 1) || (InputCheck(UnknownEnum.Value_6) && InputDuration(UnknownEnum.Value_6) > 1) || (InputCheck(UnknownEnum.Value_7) && InputDuration(UnknownEnum.Value_7) > 1))
    __dir = InputDirection(cannon_angle, UnknownEnum.Value_5, 0);

if (global.key_down && on_ground() && crouch < 1 && !spidering && !global.key_free_aim && !ball && round(xspeed) == 0 && !global.key_aim_lock && InputCheck(UnknownEnum.Value_1) && InputDuration(UnknownEnum.Value_1) == 2 && abs(__dir - 270) < 11)
{
    crouch = 1;
    
    if (ds_zero("Morph Ball") != 1 && crouch >= 2)
        crouch = 1;
    
    bitsound(sndSamusTurn, 0.5);
}

if (((global.key_up && InputCheck(UnknownEnum.Value_0) && InputDuration(UnknownEnum.Value_0) == 2 && abs(__dir - 90) < 11) || global.key_right_long || global.key_left_long) && !global.key_down && crouch < 2 && !ball && on_ground() && crouch > 0 && !spidering && !global.key_free_aim && !global.key_aim_lock)
{
    crouch -= 1;
    aim_lock = 12;
    bitsound(sndSamusTurn, 0.5);
}

if (global.key_ball && ds_zero("Morph Ball") == 1)
{
    if (ball)
    {
        if (!spidering)
        {
            ball = 0;
            crouch = 3;
            samus_masks();
            
            if (place_meeting(x, y, par_solid))
            {
                __x = x;
                __y = y;
                unclip_try();
                
                if (place_meeting(x, y, par_solid))
                {
                    x = __x;
                    y = __y;
                    crouch = 0;
                    ball = 1;
                    bomb_scatter();
                    samus_masks();
                }
            }
            
            if (!place_meeting(x, y, par_solid))
            {
                bitsound(sndSamusBallOut);
                
                if (global.key_aim_lock)
                {
                    facing = lock_facing;
                    spr_facing = lock_spr_facing;
                }
                
                samus_masks();
            }
        }
    }
    else
    {
        bomb_scatter();
        charge_counter = 0;
        turn = 0;
        bitsound(sndSamusBall);
        crouch = 2;
        samus_masks();
    }
    
    exit;
}

if (ds_zero("Morph Ball Bomb") && global.key_shoot && ball && instance_number(obj_bomb) < 3)
{
    vibrate(0.27, 7);
    instance_create(x, y + 6, obj_bomb);
}

if (place_meeting(x, y, obj_bomb) && yspeed >= 0 && !in_water)
{
    bomb_x = instance_place(x, y, obj_bomb).x;
    bom = instance_place(x, y, obj_bomb);
    
    if (bom.sprite_index == bom.boom_spr)
        can_bomb_jump = 1;
    else
        can_bomb_jump = 0;
    
    if (!(on_ground() && (global.key_right || global.key_left) && !place_meeting(x + xspeed, y, par_solid)))
    {
        bombjump_charge += 1;
        
        if (bombjump_charge > 2 && can_bomb_jump)
        {
            if (bomb_x != x)
            {
                xspeed = (x - bomb_x) / 3.2;
                xspeed = clamp(xspeed, -2, 2);
            }
            
            spin = 1;
            yspeed = -walljumpspeed;
        }
    }
    else
    {
        bombjump_charge = 0;
    }
}
else
{
    bombjump_charge = 0;
}

if (ds_zero("Power Bombs") > 0 && global.key_missile && ball && instance_number(obj_power_bomb) == 0)
{
    instance_create(x, y + 6, obj_power_bomb);
    vibrate(0.8, 8);
    ds_add("Power Bombs", -1);
}

function go_to_pos(arg0, arg1, arg2 = 3)
{
    repeat (arg2)
    {
        if (x < arg0)
            x += 1;
        
        if (x > arg0)
            x -= 1;
        
        if (y < arg1)
            y += 1;
        
        if (y > arg1)
            y -= 1;
    }
}

if (instance_exists(stone_toad))
{
    if (stone_toad.object_index == obj_enemy_stone_toad)
    {
        if (stone_toad.spit_counter == 1)
        {
            return_x = stone_toad.x + (stone_toad.image_xscale * 30);
            return_y = stone_toad.y + 2;
        }
        
        if (stone_toad.spit_counter < 150)
        {
            go_to_pos(stone_toad.x + (stone_toad.image_xscale * 8), stone_toad.y + 2, 3);
            ball = 1;
            bomb_scatter();
            xspeed = 0;
            yspeed = 0;
            grappling = 0;
        }
        else
        {
            if (stone_toad.spit_counter == 150)
                bitsound(sndStoneToad, 0.69);
            
            go_to_pos(return_x, return_y, 5);
            stone_toad.image_index = 1;
            
            if (abs(x - return_x) < 3 && abs(y - return_y) < 3)
            {
                x = return_x;
                y = return_y;
                xspeed = stone_toad.image_xscale * 0.42;
                yspeed = -4.669;
                spin = 1;
                just_grappled = 1;
                stone_toad.spit_counter = 0;
                stone_toad.swallow_counter = 0;
                stone_toad = 0;
            }
        }
    }
}

if (!instance_exists(stone_toad))
    stone_toad = 0;

if (instance_exists(stone_toad))
{
    if (stone_toad.object_index == obj_enemy_triclops)
    {
        repeat (7)
        {
            if (stone_toad.x < x)
                x -= 1;
            
            if (stone_toad.x > x)
                x += 1;
            
            if ((stone_toad.y - 6) > y)
                y += 1;
            
            if ((stone_toad.y - 6) < y)
                y -= 1;
        }
        
        ball = 1;
        bomb_scatter();
        xspeed = 0;
        hurt = 0;
        i_frames = 0;
        yspeed = 0;
        grappling = 0;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7
}
