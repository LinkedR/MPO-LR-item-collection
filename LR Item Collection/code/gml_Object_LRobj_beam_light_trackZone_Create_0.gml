if (instance_exists(par_enemy))
{
    cannon_align();
    var t_list = ds_list_create();
    var t_quantity = instance_place_list(x, y, par_enemy, t_list, false);
    
    if (beams >= t_quantity)
    {
        for (var e = 0; e < t_quantity; e++)
        {
            var t_entity = ds_list_find_value(t_list, e);
            var t_x = t_entity.x;
            var t_y = t_entity.y;
            
            with (mom)
            {
                LRscr_helper_instance_create(other.x, other.y, LRobj_beam_plasma_sub, 
                {
                    lightImpact_x: t_x,
                    lightImpact_y: t_y
                });
            }
        }
    }
    else
    {
        repeat (beams)
        {
            var t_target = irandom(t_quantity - 1);
            var t_entity = ds_list_find_value(t_list, t_target);
            var t_x = t_entity.x;
            var t_y = t_entity.y;
            
            with (mom)
            {
                LRscr_helper_instance_create(other.x, other.y, LRobj_beam_plasma_sub, 
                {
                    lightImpact_x: t_x,
                    lightImpact_y: t_y
                });
            }
        }
    }
    
    ds_list_destroy(t_list);
}

instance_destroy();
