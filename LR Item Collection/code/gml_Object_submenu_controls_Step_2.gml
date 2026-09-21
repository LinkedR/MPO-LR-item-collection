if (global.key_cancel && !rebinding_active && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    leaving = 1;
    exit;
}

if (!leaving)
{
    menu_offset = lerp(menu_offset, 0, 0.1);
}
else
{
    menu_offset = lerp(menu_offset, global._screen_height, 0.1);
    
    if (menu_offset > (global._screen_height - 32))
        instance_destroy();
}

if (menu_offset > 32)
    exit;

if (rebinding_active)
{
    if (InputDeviceGetRebindingResult(dev) != undefined)
    {
        if (InputDeviceGetGamepadType(dev) != 0)
            InputBindingSetSafe(1, rebinding_verb_enum, InputDeviceGetRebindingResult(dev));
        else
            InputBindingSetSafe(0, rebinding_verb_enum, InputDeviceGetRebindingResult(dev));
        
        InputDeviceSetRebinding(dev, 0);
        ds_write_options("Controls", json_stringify(InputBindingsExport(1, 0)));
        ds_write_options("Key Controls", json_stringify(InputBindingsExport(0, 0)));
        save_options();
        rebinding_active = 0;
    }
    
    exit;
}

// ----- LRedit : added button to the menu -----
menu_selection += menu_opposing_delta(UnknownEnum.Value_0, UnknownEnum.Value_1);
menu_selection += (InputOpposingPressed(UnknownEnum.Value_2, UnknownEnum.Value_3) * 11);
menu_selection = (menu_selection + 24) % 24;
// ---------------------------------------------

if (InputPressed(UnknownEnum.Value_8) && !global.key_up && !global.key_down && !global.key_left && !global.key_right && !rebinding_active)
{
    switch (menu_selection)
    {
        case 0:
            rebinding_verb_enum = UnknownEnum.Value_2;
            break;
        
        case 1:
            rebinding_verb_enum = UnknownEnum.Value_3;
            break;
        
        case 2:
            rebinding_verb_enum = UnknownEnum.Value_0;
            break;
        
        case 3:
            rebinding_verb_enum = UnknownEnum.Value_1;
            break;
        
        case 4:
            rebinding_verb_enum = UnknownEnum.Value_14;
            break;
        
        case 5:
            rebinding_verb_enum = UnknownEnum.Value_15;
            break;
        
        case 6:
            rebinding_verb_enum = UnknownEnum.Value_16;
            break;
        
        case 7:
            rebinding_verb_enum = UnknownEnum.Value_17;
            break;
        
        case 8:
            rebinding_verb_enum = UnknownEnum.Value_18;
            break;
        
        case 9:
            rebinding_verb_enum = UnknownEnum.Value_19;
            break;
        
        case 11:
            rebinding_verb_enum = UnknownEnum.Value_25;
            break;
        
        case 10:
            rebinding_verb_enum = UnknownEnum.Value_26;
            break;
        
        case 12:
            rebinding_verb_enum = UnknownEnum.Value_20;
            break;
        
        case 13:
            rebinding_verb_enum = UnknownEnum.Value_21;
            break;
        
        case 14:
            rebinding_verb_enum = UnknownEnum.Value_22;
            break;
        
        case 15:
            rebinding_verb_enum = UnknownEnum.Value_23;
            break;
        
        case 16:
            rebinding_verb_enum = UnknownEnum.Value_27;
            break;
        
        case 17:
            rebinding_verb_enum = UnknownEnum.Value_8;
            break;
        
        case 18:
            rebinding_verb_enum = UnknownEnum.Value_9;
            break;
        
        case 19:
            rebinding_verb_enum = UnknownEnum.Value_10;
            break;
        
        case 20:
            rebinding_verb_enum = UnknownEnum.Value_11;
            break;
        
        case 21:
            rebinding_verb_enum = UnknownEnum.Value_28;
            break;
        
        case 22:
            rebinding_verb_enum = UnknownEnum.Value_24;
            break;
        // ----- LRedit : new inputs -----
        case 23:
            rebinding_verb_enum = UnknownEnum.Value_29;
            break;
        // -------------------------------                                  
        
        default:
            rebinding_verb_enum = -1;
            break;
    }
    
    dev = InputPlayerGetDevice(0);
    InputDeviceSetRebinding(dev, true);
    rebinding_active = true;
}

if (global.key_menu && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    InputBindingsReset(false, 0);
    InputBindingsReset(true, 0);
    bitsound(sndPauseReject);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_11,
    Value_14 = 14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29 // ---- LRedit : enum increase -----
}
