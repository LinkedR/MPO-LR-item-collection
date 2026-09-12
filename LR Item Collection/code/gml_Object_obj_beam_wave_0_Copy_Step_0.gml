cannon_step();

if (place_meeting(x, y, par_player))
    beam_travel_straight(7, angle);
else
    beam_travel_wavy(5, angle, wavelength, 3);

if (_reflected)
    alarm[0] += 1;
