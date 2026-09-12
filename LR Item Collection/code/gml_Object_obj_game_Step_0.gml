// ----- LRedit : item toggling for testing -----
LRscr_items_toggle();
// ----------------------------------------------

ds_add("Real Milliseconds", (delta_time / 1000000) * 60);

if (dz("Real Milliseconds") >= 60)
{
    ds_add("Real Milliseconds", -60);
    ds_add("Real Seconds", 1);
}

if (dz("Real Seconds") >= 60)
{
    ds_add("Real Seconds", -60);
    ds_add("Real Minutes", 1);
}

if (dz("Real Minutes") >= 60)
{
    ds_add("Real Minutes", -60);
    ds_add("Real Hours", 1);
}

_ts = "[fnt_Logbook][fa_left][fa_top]";

if (dz("Real Hours") < 10)
    _ts += "0";

_ts += ds_quote("Real Hours");
_ts += ":";

if (dz("Real Minutes") < 10)
    _ts += "0";

_ts += ds_quote("Real Minutes");
_ts += ":";

if (dz("Real Seconds") < 10)
    _ts += "0";

_ts += ds_quote("Real Seconds");
_ts += (" " + txt("Real Time"));
ds_write("Real Time String", _ts);

if (!instance_exists(obj_samus))
    exit;

if (obj_samus.pose || global.cutscene || global.fanfare != -4 || instance_exists(obj_elevator_transition))
    exit;

ds_add("Milliseconds", 1);

if (ds_zero("Milliseconds") >= 60)
{
    ds_add("Milliseconds", -60);
    ds_add("Seconds", 1);
}

if (ds_zero("Seconds") >= 60)
{
    ds_add("Seconds", -60);
    ds_add("Minutes", 1);
}

if (ds_zero("Minutes") >= 60)
{
    ds_add("Minutes", -60);
    ds_add("Hours", 1);
}

_ts = "[fnt_Logbook][fa_left][fa_top]";

if (dz("Hours") < 10)
    _ts += "0";

_ts += ds_quote("Hours");
_ts += ":";

if (dz("Minutes") < 10)
    _ts += "0";

_ts += ds_quote("Minutes");
_ts += ":";

if (dz("Seconds") < 10)
    _ts += "0";

_ts += ds_quote("Seconds");
_ts += (" " + txt("Elapsed"));
ds_write("Time String", _ts);
