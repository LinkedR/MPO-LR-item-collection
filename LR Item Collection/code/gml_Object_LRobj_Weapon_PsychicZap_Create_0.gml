if !instance_exists(par_enemy)
{
    instance_destroy();
}
else
{
    var t_target = instance_nearest(x,y,par_enemy);
    if distance_to_object(t_target) < 96
    {
        image_angle = point_direction(x,y,t_target.x,t_target.y);
        var t_distance = max(1,point_distance(x,y,t_target.x,t_target.y));
        image_xscale = t_distance / 32;
        image_yscale = choose(1,-1);
    }
    else
    {
        instance_destroy();
    }
}