if (scan_number < 0)
    exit;

scan_identity();
_name_array = ds_zero(scan_category);
log_array = ds_zero(scan_array_name);
scan_identity();
_name_array[scan_number] = scan_name;
ds_write(scan_category, _name_array);
scan_identity();
log_array[scan_number] = scan_log;
ds_write(scan_array_name, log_array);

if (!dz(scan_key))
{
    if (scan_category != "Chozo Artifacts")
        ds_add("Logbook", 1);
    
    // ----- LRedit : recalculate buff -----
    LRscr_items_KnowledgeExploit_calc();
    // -------------------------------------
    
    ds_add("Successful Scans", 1);
    ds_write(scan_key, 1);
    
    with (instance_create_depth(x, y, 0, obj_new_scan))
    {
        scan_category = other.scan_category;
        scan_id = other.scan_number;
    }
}
