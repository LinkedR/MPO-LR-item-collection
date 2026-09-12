cannon_step();
beam_hit_wall();
beam_travel_straight(5, angle);

if (_reflected)
    alarm[0] += 1;
