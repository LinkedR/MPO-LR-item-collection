event_inherited();
self.damage = 18;
self.damage_type = "Fire";
self.i_frames = 3;
self.damage_mod = 180;
self.is_beam = true;
self.impact_destroy = true;
self.plasma = true;
self.og_damage = damage;

if (dz("Incinerator"))
    self.damage_mod = 320;
