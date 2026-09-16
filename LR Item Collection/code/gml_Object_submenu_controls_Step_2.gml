if (global.key_cancel && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    if (rebinding_active)
    {
        InputDeviceSetRebinding(rebinding_device, false);
        rebinding_active = false;
        rebinding_verb_enum = -1;
        bitsound(sndPauseReject);
        exit;
    }
    
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
    var _device = rebinding_device;
    
    if (InputDeviceGetRebinding(_device))
    {
        var _result = InputDeviceGetRebindingResult(_device);
        
        if (__MPOIsValidGamepadBindingValue(_result))
        {
            var _boundVerb = rebinding_verb_enum;
            
            if (false && InputDeviceIsGamepad(_device) && (_result == 32799 || _result == 32800 || _result == 32801 || _result == 32802 || _result == 32803 || _result == 32809 || _result == 32810))
            {
                __MPOInputDebugLog("rebind rejected phantom binding=" + string(_result) + " verb=" + string(_boundVerb));
                InputDeviceSetRebinding(_device, true, global.__mpo_last_rebind_wait_ignore);
                exit;
            }
            
            var _forGamepad = InputDeviceIsGamepad(_device);
            
            if ((_boundVerb == UnknownEnum.Value_8 || _boundVerb == UnknownEnum.Value_9) && __MPOAcceptCancelRebindSet(_forGamepad, _boundVerb, _result, 0))
                __MPOInputDebugLog("rebind accept/cancel swap verb=" + string(_boundVerb) + " binding=" + string(_result));
            else
                InputBindingSetSafe(_forGamepad, _boundVerb, _result);
            
            if (false && InputDeviceIsGamepad(_device))
                __MPOStripNonSystemRawMappings(_device);
            
            InputDeviceSetRebinding(_device, false);
            rebinding_active = false;
            rebinding_verb_enum = -1;
            __MPOInputDebugLog("rebind done verb=" + string(_boundVerb) + " binding=" + string(_result) + " dev=" + string(_device) + " native_sdl=" + string(__MPOAndroidUsesNativeSystemButtons(_device)) + " mpo_raw=" + string(__MPOExportRawMaps()));
        }
        else if (_result != undefined)
        {
            __MPOInputDebugLog("rebind ignored invalid result=" + string(_result) + " verb=" + string(rebinding_verb_enum));
        }
        
        exit;
    }
    
    __MPOInputDebugLog("rebind handler lost dev=" + string(_device) + " verb=" + string(rebinding_verb_enum));
    rebinding_active = false;
    rebinding_verb_enum = -1;
    
    if (global.key_menu)
    {
        InputDeviceSetRebinding(_device, false);
        bitsound(sndPauseReject);
    }
    
    exit;
}

// ----- LRedit : added button to the menu -----
menu_selection += menu_opposing_delta(UnknownEnum.Value_0, UnknownEnum.Value_1);
menu_selection += (InputOpposingPressed(UnknownEnum.Value_2, UnknownEnum.Value_3) * 11);
menu_selection = (menu_selection + 24) % 24;
// ---------------------------------------------

if (InputPressed(UnknownEnum.Value_8) && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
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
    
    if (rebinding_verb_enum >= 0)
    {
        rebinding_device = InputPlayerGetDevice(0);
        
        if (rebinding_device == undefined)
            rebinding_device = -100;
        
        if (!InputDeviceIsGamepad(rebinding_device))
        {
            var _pad = __MPOFirstConnectedGamepad(-1);
            
            if (_pad >= 0)
                rebinding_device = _pad;
        }
        
        global.__mpo_rebind_target_gp = __MPORebindTargetGpForVerb(rebinding_verb_enum);
        
        if (false && InputDeviceIsGamepad(rebinding_device))
        {
            __MPOApplyAndroidSdlBootstrap(rebinding_device);
            __MPOAndroidApplySystemReaders(rebinding_device);
        }
        
        global.__mpo_last_rebind_raw = undefined;
        var _wait_ignore = [27];
        
        if (false && InputDeviceIsGamepad(rebinding_device))
        {
            var _rebindGp = global.__mpo_rebind_target_gp;
            
            if (_rebindGp != 32785 && _rebindGp != -32785)
                array_push(_wait_ignore, 32785, -32785);
            
            if (_rebindGp != 32786 && _rebindGp != -32786)
                array_push(_wait_ignore, 32786, -32786);
            
            if (_rebindGp != 32787 && _rebindGp != -32787)
                array_push(_wait_ignore, 32787, -32787);
            
            if (_rebindGp != 32788 && _rebindGp != -32788)
                array_push(_wait_ignore, 32788, -32788);
            
            if (_rebindGp != 32781)
                array_push(_wait_ignore, 32781);
            
            if (_rebindGp != 32782)
                array_push(_wait_ignore, 32782);
            
            if (_rebindGp != 32783)
                array_push(_wait_ignore, 32783);
            
            if (_rebindGp != 32784)
                array_push(_wait_ignore, 32784);
            
            array_push(_wait_ignore, 32799, 32800, 32801, 32802, 32803, 32809, 32810);
            
            if (_rebindGp != 32775 && _rebindGp != 32776)
                array_push(_wait_ignore, 32775, 32776);
            
            if (_rebindGp != 32773 && _rebindGp != 32774)
                array_push(_wait_ignore, 32773, 32774);
            
            if (rebinding_verb_enum != UnknownEnum.Value_28)
                array_push(_wait_ignore, 32777);
            
            if (rebinding_verb_enum != UnknownEnum.Value_27)
                array_push(_wait_ignore, 32778);
            
            var _targetGp = global.__mpo_rebind_target_gp;
            var _faces = [32769, 32770, 32771, 32772];
            var _fi = 0;
            
            repeat (array_length(_faces))
            {
                if (_faces[_fi] != _targetGp)
                    array_push(_wait_ignore, _faces[_fi]);
                
                _fi++;
            }
        }
        
        InputVerbConsume(UnknownEnum.Value_14, 0);
        InputVerbConsume(UnknownEnum.Value_8, 0);
        __MPOInputDebugLog("rebind start verb=" + string(rebinding_verb_enum) + " dev=" + string(rebinding_device) + " in_game_pause=" + string(instance_exists(menu_choice)));
        InputDeviceSetRebinding(rebinding_device, true, _wait_ignore);
        global.__mpo_last_rebind_wait_ignore = _wait_ignore;
        rebinding_active = true;
    }
}

if (global.key_menu && !global.key_up && !global.key_down && !global.key_left && !global.key_right)
{
    InputBindingsReset(false, 0);
    InputBindingsReset(true, 0);
    global.__mpo_controls_loaded = 0;
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
