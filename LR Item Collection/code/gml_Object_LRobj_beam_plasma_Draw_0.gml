if (!isLightShot)
{
    draw_self();
}
else
{
    draw_sprite_ext(LRspr_Beam_Light_end, image_index, vi_x, vi_y, 1, image_yscale, angle, c_white, 1);
    draw_sprite_ext(LRspr_Beam_Light_centre, image_index, vi_x, vi_y, image_xscale, image_yscale, angle, c_white, 1);
    draw_sprite_ext(LRspr_Beam_Light_end, image_index, lightImpact_x, lightImpact_y, -1, image_yscale, angle, c_white, 1);
}
