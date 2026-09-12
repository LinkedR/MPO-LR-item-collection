if (!instance_exists(mom) || !in_view(8))
{
    instance_destroy();
    exit;
}

if ((other.object_index == obj_grapple_mask && mom.object_index == obj_enemy_glider) || mom.true_i_frames)
    exit;

mom.damage_taken = other.damage;
mom.damage_taken_type = other.damage_type;
mom.damage_taken_mod = other.damage_mod;
mom.damage_charged = other.charged + (other.damage_type == "Concussive");
mom.damage_i_frames = other.i_frames * 3;
mom.damage_id = other.id;
mom.damage_object = other.object_index;
mom.critical = 0;
// ----- LRedit : exponential damage setup/increment -----
var t_exponentialDamage = LRscr_helper_default(other, "exponentialDamage", 0);

if (t_exponentialDamage > 0)
{
    var t_exponentialDamageAccumulated = LRscr_helper_default(mom, "exponentialDamageAccumulated", 0);
    mom.damage_taken += t_exponentialDamageAccumulated;
    mom.exponentialDamageAccumulated = t_exponentialDamageAccumulated + t_exponentialDamage;
}
// -------------------------------------------------------

if (mom.damage_taken_type == "Ice" && (mom.object_index == obj_enemy_metroid || mom.object_index == obj_enemy_hunter_metroid || mom.object_index == obj_enemy_glider || mom.object_index == obj_enemy_ice_metroid) && mom.hp > 33)
{
    mom.hp = 33;
    
    if (mom.object_index == obj_enemy_glider)
        mom.hp = 37;
}

with (mom)
{
    reflected = 0;
    
    if (scan_blacklist(damage_id))
        break;
    
    if (shielded > 0)
    {
        shielded -= 1;
        reflected = 1;
    }
    
    if (check_resistance("Normal") && damage_taken_type == "Normal" && damage_id.object_index != obj_bomb)
        reflected = 1;
    
    if ((check_resistance("Concussive") && damage_id.object_index != obj_bomb) && (damage_taken_type == "Concussive" || damage_id.is_missile))
        reflected = 1;
    
    if (check_resistance("Uncharged") && damage_charged == 0 && damage_id.object_index != obj_bomb)
        reflected = 1;
    
    if (check_resistance("Electric") && damage_taken_type == "Electric" && !damage_id.is_missile && damage_id.object_index != obj_bomb)
        reflected = 1;
    
    if (check_resistance("Fire") && damage_taken_type == "Fire" && !damage_id.is_missile && damage_id.object_index != obj_bomb)
        reflected = 1;
    
    if (check_resistance("Ice") && damage_taken_type == "Ice" && !damage_id.is_missile && damage_id.object_index != obj_bomb)
        reflected = 1;
    
    // ----- LRedit : Phazon beam inclusion -----
    if (reflected == 1 && (damage_object != obj_beam_phazon_0 && damage_object != LRobj_beam_phazon_segment))
    {
        // --------------------------------------
        new_damage_number("REFLECTED", x, y, 16554078);
        break;
    }
    else
    {
        reflected = 0;
    }
    
    damage_id._reflected = reflected;
    
    if (reflected)
    {
        instance_create(damage_id.x, damage_id.y, obj_effect_reflect);
        damage_id._reflected = reflected;
    }
    
    frozen = 0;
    burning = 0;
    paralyzed = 0;
    
    function status_apply()
    {
        if (!can_status)
        {
            state = "Normal";
            exit;
        }
        
        if (state == "Normal")
        {
            state = damage_taken_type;
            
            if (state_timer < damage_taken_mod)
                state_timer = damage_taken_mod;
        }
    }
    
    if (damage_taken_type == "Fire" && irandom(1) == 0)
    {
        burning = 1;
        status_apply();
    }
    
    if (damage_taken_type == "Ice" && hp <= (damage_taken * 2.7))
    {
        if (!frozen)
            bitsound(sndEnemyFreeze);
        
        frozen = 1;
        
        if ((hp - damage_taken) <= 0 && hp != 1)
            hp = damage_taken + 1;
        
        status_apply();
    }
    
    if (damage_taken_type == "Electric" && (!irandom(4) || damage_charged))
    {
        paralyzed = 1;
        status_apply();
        
        if (damage_charged)
        {
            begin_x = x;
            being_shocked = 4;
        }
        
        state_timer *= 3;
    }
    
    hp -= damage_taken;
    // ----- LRedit : regain a portion of the damage dealt as health -----
    if (dz("LRItems Life Drain"))
    {
        var t_healUp = ceil(damage_taken * 0.01);
        new_damage_number("+" + string(t_healUp), x, y - 5, 15561728, 1);
        ds_add("Energy", t_healUp);
    }
    // -------------------------------------------------------------------
    
    ds_add("Damage Dealt", damage_taken);
    report = "";
    col = 12369084;
    
    if (frozen)
    {
        col = 16760639;
        report += "FROZEN\n";
    }
    
    if (burning)
    {
        col = 77019;
        report += "BURNED\n";
    }
    
    if (paralyzed)
    {
        col = 4177906;
        report += "SHOCKED\n";
    }
    
    if (critical)
        report += (txt("CRITICAL") + "!!\n");
    
    report += string(damage_taken);
    new_damage_number(report, x, y, col);
    i_frames = 7;
    
    if (hp > 0)
        bitsound(sndEnemyDamage, 0.9 + random(0.2));
    
    array_push(blacklist, [damage_id, damage_i_frames]);
}

if (mom.reflected && mom.visual_mask_type != obj_visual_mask_weak_spot)
    reflect_weapon(other);
