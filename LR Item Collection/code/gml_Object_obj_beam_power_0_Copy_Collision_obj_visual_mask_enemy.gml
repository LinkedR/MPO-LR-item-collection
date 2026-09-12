if (instance_exists(other.mom))
{
    if (other.mom.hp <= 0)
        exit;
}

if (alarm[0] <= 0 && !_reflected)
    alarm[0] = 3;
