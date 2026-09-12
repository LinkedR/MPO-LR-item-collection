if (!isLightShot)
{
    draw_self();
}
else
{
    draw_sprite_ext(LRspr_Beam_Light_sub_end, image_index, x, y, 1, image_yscale, image_angle, c_white, 1);
    draw_sprite_ext(LRspr_Beam_Light_sub_centre, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
    draw_sprite_ext(LRspr_Beam_Light_sub_end, image_index, lightImpact_x, lightImpact_y, -1, image_yscale, image_angle, c_white, 1);
}
