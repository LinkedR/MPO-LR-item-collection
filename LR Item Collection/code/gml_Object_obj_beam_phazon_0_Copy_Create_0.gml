bitsound(sndBeamPhazon);
cannon_align();
x += lengthdir_x(16, angle);
y += lengthdir_y(16, angle);
angle += irandom_range(-8, 8);
get_hefty();
target = -4;
var t_best = -4;
var t_best_dist = 999999;

with (par_enemy)
{
    var t_dis = point_distance(other.x, other.y, x, y);
    var t_dir = point_direction(other.x, other.y, x, y);
    
    if (abs(angle_difference(t_dir, other.angle)) < 60)
    {
        if (t_dis < t_best_dist)
        {
            t_best_dist = t_dis;
            t_best = id;
        }
    }
}

laser_end_x = x;
laser_end_y = y;
target = t_best;
segment_count = 16;
segment_length = 16;
segments_x = array_create(segment_count);
segments_y = array_create(segment_count);
segments_angle = array_create(segment_count);
var t_base_angle = angle;
var t_turn_max = 6;
var t_x = x;
var t_y = y;

for (var i = 0; i < segment_count; i++)
{
    segments_x[i] = t_x;
    segments_y[i] = t_y;
    
    if (target != -4)
    {
        var t_dir_to_target = point_direction(t_x, t_y, target.x, target.y);
        var t_difference = angle_difference(t_dir_to_target, t_base_angle);
        t_base_angle = t_base_angle + clamp(t_difference, -t_turn_max, t_turn_max);
    }
    
    segments_angle[i] = t_base_angle;
    var t_spacing_x = lengthdir_x(segment_length * 0.5, t_base_angle);
    var t_spacing_y = lengthdir_y(segment_length * 0.5, t_base_angle);
    
    with (mom)
        LRscr_helper_instance_create(t_x + t_spacing_x, t_y + t_spacing_y, LRobj_beam_phazon_segment, {});
    
    t_x += (t_spacing_x * 2);
    t_y += (t_spacing_y * 2);
    
    if (i == (segment_count - 1))
    {
        laser_end_x = t_x;
        laser_end_y = t_y;
    }
}

visible = true;
