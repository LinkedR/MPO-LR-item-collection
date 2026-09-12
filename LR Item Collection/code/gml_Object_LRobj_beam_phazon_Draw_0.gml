for (var i = 0; i < segment_count; i++)
{
    var t_sprite = LRspr_Beam_Phazon_centre;
    var t_facing = 1;
    
    if (i == 0)
    {
        t_sprite = LRspr_Beam_Phazon_end;
        t_facing = 1;
        draw_sprite_ext(t_sprite, image_index, segments_x[i + 1], segments_y[i + 1], t_facing, 1, segments_angle[i], c_white, 1);
    }
    else
    {
        if (i == (segment_count - 1))
        {
            t_sprite = LRspr_Beam_Phazon_end;
            t_facing = -1;
        }
        
        draw_sprite_ext(t_sprite, image_index, segments_x[i], segments_y[i], t_facing, 1, segments_angle[i], c_white, 1);
    }
}
