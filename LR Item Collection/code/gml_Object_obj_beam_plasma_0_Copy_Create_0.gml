bitsound(sndBeamPlasma);
cannon_align();

if (!dz("Incinerator"))
{
    become_charge_shot(sprPlasmaBeamCharged, sndBeamPlasmaCharged, sndBeamPlasma, 8.333);
    self.shrinkFactor = 0.69;
    self.hasIncinerator = false;
}
else
{
    become_charge_shot(sprPlasmaBeamCharged, sndBeamPlasmaCharged, sndBeamFlamethrower, 8.333);
    self.shrinkFactor = 0.36;
    self.hasIncinerator = true;
}

if (charged && dz("Proximity Beam"))
    spawn(obj_aeon_charge_slash_3);

get_hefty();

if (object_index == LRobj_beam_plasma)
{
    if (!dz("LRItems Light Blaze"))
    {
        isLightShot = false;
        image_yscale = 1;
        image_xscale = 0.5;
    }
    else
    {
        //x += lengthdir_x(16, angle);
        //y += lengthdir_y(16, angle);
        vi_x = x + lengthdir_x(16,angle);
        vi_y = y + lengthdir_y(16,angle);
        isLightShot = true;
        lightImpact_x = 0;
        lightImpact_y = 0;
        mask_index = LRspr_Beam_Light_centre;
        var t_maxLength = 320;
        var t_step = 16;
        var t_dist = 0;
        
        repeat (t_maxLength / t_step)
        {
            var t_x = x + lengthdir_x(t_dist, angle);
            var t_y = y + lengthdir_y(t_dist, angle);
            
            if (position_meeting(t_x, t_y, par_solid) && !position_meeting(t_x, t_y, obj_block_ice))
                break;
            
            t_dist += t_step;
        }
        
        while (t_dist > 0)
        {
            var t_x = x + lengthdir_x(t_dist, angle);
            var t_y = y + lengthdir_y(t_dist, angle);
            
            if (!position_meeting(t_x, t_y, par_solid) || position_meeting(t_x, t_y, obj_block_ice))
            {
                lightImpact_x = t_x;
                lightImpact_y = t_y;
                break;
            }
            
            t_dist -= 1;
        }
        
        image_xscale = t_dist / t_step;
        visible = true;
        x += lengthdir_x(2, angle);
        y += lengthdir_y(2, angle);
    }
}

if (self.hasIncinerator)
{
    exponentialDamage = 0.5;
    
    if (object_index == LRobj_beam_plasma)
    {
        with (mom)
        {
            if (!dz("LRItems Light Blaze"))
            {
                LRscr_helper_instance_create(x, y, LRobj_beam_plasma_sub, 
                {
                    angleVariant: 1
                });
                LRscr_helper_instance_create(x, y, LRobj_beam_plasma_sub, 
                {
                    angleVariant: -1
                });
            }
            else
            {
                var t_beamQuantity = other.charged ? 5 : 2;
                LRscr_helper_instance_create(other.x, other.y, LRobj_beam_light_trackZone, 
                {
                    image_xscale: other.image_xscale * 1.2,
                    image_angle: other.angle,
                    beams: t_beamQuantity
                });
            }
        }
    }
}
