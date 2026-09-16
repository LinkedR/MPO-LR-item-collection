// ----- LREdit: custom stat initiation -----
lrstate = 
{
    pressed_side: false,
    last_side: -10,
    shifttap: 0,
    shift_available: 3
};
// -------------------------------------------

if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

suit_sprites_new(0);
beam_object = obj_beam_power_0;
oob = 0;
tap_ball = 0;
double = 0;
flippied = 0;
facing = 1;
crouch = 0;
pose = 2;
depth = 5;
xprev = x;
yprev = y;
_x = x;
_y = y;
no_grip = 0;
climb_count = 0;
just_stuck = 0;
clip_x = x;
clip_y = y;
boosted = 0;
gravitying = 0;
just_shot_a_charge_shot = 0;
frozen_grapple = 0;
off_x = 0;
off_y = 0;
was_ball = 0;
i_initiated_this_jump = 0;
spin_counter = 0;
fall_time = 0;
clip_time = 0;
bouncing = 0;
safe_x = x;
safe_y = y;
debugging = 0;
walljump_dir = 1;
walljump_yspeed = 1;
flickback_protector = 0;
side_dashed = 0;
side_counter = 0;
cleets_flash = 0;
aeon_counter = 0;
multiplier = 1;
mash_timer = 0;
cannon_spr = spr_cannon_r;
cannon_pal = 0;
droplet_counter = 0;
clip_dir = 0;
stuck_on_wall = 0;
lastused_missile = 0;
sprinting = 0;
plasma_counter = 0;
auto_recover = 0;
aqua_recover = 0;
missile_recover = 0;
pb_recover = 0;
top_sprite = spr_nothing;
top_x = 0;
top_y = 0;
top_frame = 0;
feet_dangle = 0;
spr_facing = 1;
bombjump_charge = 0;
ball_facing = 1;
aim_lock_engaged = 0;
grap_offset = 0;
grounded = 0;
roomstart_x = x;
roomstart_y = y;
prev_air = 0;
grap_xprev = 0;
grap_yprev = 0;
grapple_reverse = 1;
started = 0;
lock_on_target = -6669;
clink = 0;
can_ang = 0;
blacklist = [];
in_blacklist = 0;
aim_reset_lag = 0;
player_stuck = 0;
missile_recoil = 0;
standup_time = 0;
dodge_factor = 1;
quarter_piping = 0;
stone_toad = 0;
rolling = 0;
flung_up = 0;
ice_shake_x = 0;
grounded = 0;
grapple_bead_counter = 0;
alarm[1] = 1;
shadowColor = 0;

drawMySilhouette = function()
{
    shader_set(shdDrawSolidColor);
    
    if (!grappling)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, shadowColor, image_alpha);
    }
    else if (pose == 0)
    {
        draw_sprite_ext(sprite_index, image_index, x, y - 12, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x + 1, y - 12, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x, (y + 1) - 12, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x - 1, y - 12, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x, y - 1 - 12, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x + 1, (y - 12) + 1, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x + 1, y - 12 - 1, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x - 1, (y - 12) + 1, image_xscale, image_yscale, rot, shadowColor, 1);
        draw_sprite_ext(sprite_index, image_index, x - 1, y - 12 - 1, image_xscale, image_yscale, rot, shadowColor, 1);
    }
    
    shader_reset();
};

physics_init();
player = 0;
on_platform = 0;
mashing = 0;
mash = 0;
burning = 0;
frozen = 0;
paralyzed = 0;
status_flasher = 0;
state_timer = 0;
ice_shake = 0;
gripping = 0;
can_grip = 0;
climbing = 0;
grip_aiming = 0;
dangle_frame = 0;
grip_input = 0;
grip_y = 0;
grip_x = 0;
climb_y = 0;
climb_x = 0;
morph_grip = 0;
spawn(obj_power_grip_mask);
i_frames = 0;
i_frame_period = 60;
i_frames_chip = 0;
hurt = 0;
hurt_dir = 1;
hurt_fling = 2.42;
hurt_timer = 0;
spin = 0;
screwing = 0;
critical_energy = 0;
boost_counter = 0;
boost_min = 5;
boost_max = 60;
og_boost_max = boost_max;
boosting = 0;
boost_factor = 0;
boost_residue = 0;
boost_dir = 0;
cannon_angle = 0;
cannon_frame = 0;
spazer_id = 0;
charge_counter = 0;
beam_charged = 0;
beam_queue = 0;
changing_beam = 0;
charge_max = 45;
missile = 0;
phazon_beam = 0;
phazon_scroll = 1;
charge_sfx = sndBeamChargingPower;
charge_loop = sndBeamChargingPower;
charge_orb = sprPowerCharge_strip4;
reticle_distance = 0;
reticle_angle = 0;
charge_x = 0;
charge_y = 0;
aim_lock = 0;
aim_lenience = 0;
backup_charge = 0;
grapple_acc = 0;
grapple_velocity = 0;
grapple_x = 0;
grapple_y = 0;
grappling = 0;
grapple = 0;
grap = 0;
can_grapple = 1;
just_grappled = 0;
grapple_angle_vel = 0;
grapple_radius = 32;
grapple_dir = 270;
grapple_pos = 0;
grapple_counter = 0;
grapple_grav = 0.75;
grapple_speed = 0;
grapple_angle = 0;
grap = 0;
grapple_stuck = 0;
artifact_3_counter = 0;
artifact_5_counter = 0;
event_user(1);
STATE = 0;
IDLE = 0;
RUNNING = 1;
event_user(2);
charge = 0;
charge_max = 60;
cooldown = 0;
recoil = 0;
can_move = 0;
pose = 0;
grip = 0;
grapple = 0;
spin = 0;
facing = 1;
courtesy_jump = 0;
dubble_jumped = 0;
crouch = 0;
ball = 0;
aim_angle = 0;
aim_tilt = 0;
turn = 0;
aiming = 0;
walljump = 0;
spidering = 0;
spider_charge = 0;
spd = 1 * sign(image_xscale);
spider_dir = 0;
dir = 0;
animDir = dir;
imgAng = dir;
fpixel = 1;
event_user(0);
event_user(3);
alarm[0] = 15;
alarm[3] = 2;
suit_sprites();

function samus_masks()
{
    if (ball || (sprite_index == s_morph_0_r || sprite_index == s_morph_0_l))
        mask_index = sprSamusBallMask;
    else if (crouch == 1 && on_ground())
        mask_index = sprSamusDuckMask;
    else
        mask_index = sprSamusMask;
    
    if (!ball && crouch == 0 && place_meeting(x, y, par_solid) && !gripping && !climbing)
    {
        crouch = 1;
        mask_index = sprSamusDuckMask;
    }
}

if (!instance_exists(obj_camera_buddy))
    instance_create(x, y, obj_camera_buddy);
