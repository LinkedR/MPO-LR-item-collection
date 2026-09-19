with (obj_samus)
{
    // ----- LRedit : Impact boost check ----
    if ((place_meeting(x + xspeed, y, other) || place_meeting(x, y + (yspeed * 2), other)) && (screwing || (dz("LRItems Impact Boost") && boosting))) 
    {
        instance_destroy(other);
        spawn(obj_effect_clink);
        clink = 9;
    }
}
