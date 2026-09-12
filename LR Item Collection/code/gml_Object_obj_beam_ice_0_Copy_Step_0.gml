cannon_step();
beam_hit_wall();
beam_travel_straight(7.77, angle);

if (_reflected)
    alarm[0] += 1;
