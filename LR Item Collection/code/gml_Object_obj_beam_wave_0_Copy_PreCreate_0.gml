event_inherited();
self.damage_type = "Electric";
self.damage = 3;
self.damage_mod = 120;
self.is_beam = true;
self.depth = -50;
self.wavy = true;
self.og_damage = damage;

if (dz("Wavebuster"))
    self.damage_mod = 200;

isAnnihilator = dz("LRItems Annihilating Wave") ? true : false;

if (isAnnihilator)
    self.damage_mod *= 1.5;
