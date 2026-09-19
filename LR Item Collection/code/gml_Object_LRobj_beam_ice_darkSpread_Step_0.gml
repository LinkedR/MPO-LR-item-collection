if (!self.lr_targetAcquired)
{
    event_inherited();
    
    if (!instance_exists(par_enemy))
        exit;
    
    var t_possibleTarget = instance_nearest(x, y, par_enemy);
    
    if (point_distance(x, y, t_possibleTarget.x, t_possibleTarget.y) < 160)
    {
        self.lr_targetID = t_possibleTarget;
        self.lr_targetAcquired = true;
    }
}
else
{
    if (!instance_exists(self.lr_targetID) || place_meeting(x,y,par_enemy))
        exit;
    
    var t_angle = point_direction(x, y, self.lr_targetID.x, self.lr_targetID.y);
    var t_diff = clamp(angle_difference(t_angle, direction), -15, 15);
    direction += t_diff;
    image_angle = direction;
}

speed *= 0.9;
