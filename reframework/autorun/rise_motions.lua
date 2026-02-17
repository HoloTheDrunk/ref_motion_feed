---@enum motion_bank_ids
local motion_bank_ids = {
  sheathed = 0,
  ---Both gestures and poses
  emote = 3,
  silkbug = 4,
  drawn = 100,
}

---@enum motion_ids
local motion_ids = {
  ---@enum sheathed
  sheathed = {
    idle = 1,
  },
  ---@enum ls
  ls = {
    idle = 1,
    unsheathe = 2,
    sheathe = 3,
    walk_loop = 4,
    walk_start_forwards = 5,
    walk_start_rotate_ccw = 6,
    walk_start_rotate_cw = 7,
    walk_end = 8,
    walk_sheathe = 9,
    roll_forward = 10,
    roll_left = 11,
    roll_right = 12,
    roll_backward = 13,
    roll_to_walk_transition = 14,
    step_slash = 101,
    overhead_slash = 102,
    fade_slash = 103,
    thrust = 104,
    rising_slash = 105,
    spirit_blade_1 = 106,
    spirit_blade_2 = 107,
    spirit_blade_3 = 108,
    spirit_blade_roundslash = 109,
    silkbind_sakura_slash_end = 109,
    spirit_step_slash = 110,
    lateral_fade_slash_right = 113,
    lateral_fade_slash_left = 114,
    drawn_double_slash = 125,
    serene_pose = 126,
    serene_pose_counter = 127,
    soaring_kick_start = 128,
    soaring_kick_flight = 130,
    soaring_kick_miss = 132,
    soaring_kick_spirit_helm_breaker_start = 133,
    soaring_kick_spirit_helm_breaker_flurry = 135,
    soaring_kick_hit = 136,
    soaring_kick_plunging_thrust = 138,
    silkbind_sakura_slash_start = 139,
    silkbind_sakura_slash_hits = 140,
    foresight_slash = 147,
    special_sheathe_hold = 152,
    special_sheathe_timeout = 153,
    special_sheathe_iai_slash = 154,
    special_sheathe_iai_spirit_slash = 155,
    special_sheathe_start = 156,
    soaring_kick_spirit_helm_breaker_downward_slash = 157,
    tempered_spirit_blade = 159,
    harvest_moon = 160,
    sacred_sheathe_start = 161,
    sacred_sheathe_counter_manual = 162,
    sacred_sheathe_focus = 163,
    sacred_sheathe_focus_loop = 164,
    sacred_sheathe_spirit_release_slash_lv1 = 170,
    sacred_sheathe_spirit_release_slash_lv2 = 171,
    sacred_sheathe_spirit_release_slash_lv3 = 172,
    sacred_sheathe_counter_auto = 173,
    sheathed_to_step_slash_transition = 302,
    thrust_to_rising_slash_transition = 307,
    thrust_to_fade_slash_transition = 308,
    drawn_double_slash_to_thrust_transition = 337,
    switch_skill_swap_evade_forward = 615,
    switch_skill_swap_evade_right = 616,
    switch_skill_swap_evade_left = 617,
    switch_skill_swap_evade_backward = 618,
    switch_skill_swap = 619,
  },
}

local weapons = {
  bow = true,
  cb = true,
  db = true,
  gl = true,
  gs = true,
  hammer = true,
  hbg = true,
  hh = true,
  ig = true,
  lance = true,
  lbg = true,
  ls = true,
  sa = true,
  sns = true
}

---@alias Weapon "bow"|"cb"|"db"|"gl"|"gs"|"hammer"|"hbg"|"hh"|"ig"|"lance"|"lbg"|"ls"|"sa"|"sns"

---Find a motion bank's name if it is known.
---@param bank_id motion_bank_ids
---@param weapon? Weapon Name of the weapon, only required if `bank_id` is 100 (="drawn").
---@return string?
local function bank_id_to_name(bank_id, weapon)
  for bank, bid in pairs(motion_bank_ids) do
    if bid == bank_id then
      if bank_id == motion_bank_ids.drawn and weapon ~= nil and weapons[weapon] ~= nil then
        return weapon
      end
      return bank
    end
  end
  return nil
end

---Find a motion's name if it is known.
---@param bank_id motion_bank_ids
---@param id integer
---@param weapon? Weapon Name of the weapon, only required if <bank_id> is 100.
---@return string?
local function ids_to_name(bank_id, id, weapon)
  local bank_name = bank_id_to_name(bank_id, weapon)
  if not bank_name or not motion_ids[bank_name] then return nil end

  for motion, mid in pairs(motion_ids[bank_name]) do
    if mid == id then
      return motion
    end
  end

  return nil
end

return {
  motions_ids = motion_ids,
  motion_bank_ids = motion_bank_ids,
  bank_id_to_name = bank_id_to_name,
  ids_to_name = ids_to_name,
}
