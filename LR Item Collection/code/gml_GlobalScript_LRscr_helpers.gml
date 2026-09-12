function LRscr_helper_instance_create(arg0, arg1, arg2, arg3)
{
    arg3.mom = id;
    
    if (!variable_instance_exists(id, "player"))
        arg3.player = 0;
    else
        arg3.player = player;
    
    return instance_create_layer(arg0, arg1, "Instances", arg2, arg3);
}

function LRscr_helper_default(arg0, arg1, arg2)
{
    if (variable_instance_exists(arg0, arg1))
        return variable_instance_get(arg0, arg1);
    else
        return arg2;
}

function LRscr_helper_filterName(arg0)
{
    var t_nameLength = string_length(arg0);
    
    if (t_nameLength > 7 && string_copy(arg0, 1, 7) == "LRItems")
        return string_copy(arg0, 9, t_nameLength - 8);
    else
        return arg0;
}
