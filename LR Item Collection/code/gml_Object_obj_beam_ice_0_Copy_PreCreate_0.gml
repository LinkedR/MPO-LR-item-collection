event_inherited();
self.damage_type = "Ice";

if (!ds_zero("Ice Spreader"))
{
    self.damage = 30;
    self.damage_mod = 240;
    self.is_beam = true;
    self.impact_destroy = true;
    self.og_damage = damage;
}
else
{
    self.damage_mod = 256;
    sprite_index = sprIceBeamUpgrade;
}

if (ds_zero("LRItems Dark Ice"))
{
    self.damage_mod *= 1.5;
    sprite_index = LRspr_Beam_DarkIce_0;
}
