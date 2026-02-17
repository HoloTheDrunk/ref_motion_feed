local motions = require("rise_motions")

---@class Motion
---@field timing number
---@field id integer
---@field bank_id integer
---@field name string?

---@type Motion[]
local stack = {}
local strs = {}

local application = sdk.find_type_definition("via.Application") --[[@as RETypeDefinition]]
local get_uptime = application:get_method("get_UpTimeSecond") --[[@as REMethodDefinition]]
---@return number
local function time() return get_uptime:call(nil) end

local function init()
  stack = {}
  strs = {}
end

local function late_update(args)
  local motion_controls = sdk.to_managed_object(args[2])
  if not motion_controls then return end

  local timing = time()

  local id = motion_controls:get_field("_OldMotionID")
  local bank_id = motion_controls:get_field("_OldBankID")
  if #stack > 0 and bank_id == stack[#stack].bank_id and id == stack[#stack].id then
    return
  end

  local name = motions.ids_to_name(bank_id, id, "ls")

  stack[#stack + 1] = {
    timing = timing,
    id = id,
    bank_id = bank_id,
    name = name
  }

  strs[#strs + 1] = string.format("%3d | %3d | %s", bank_id, id, name or "----")
end

local function draw_ui()
  imgui.text(string.format("%d motions detected", #stack))

  if #strs == 0 then return end

  local str = table.concat(strs, "\n", math.max(1, #strs - 10), #strs)
  imgui.text(str)
end

local function main()
  init()

  sdk.hook(
    sdk.find_type_definition("snow.player.PlayerMotionControl"):get_method("lateUpdate") --[[@as REMethodDefinition]],
    late_update
  )

  re.on_draw_ui(function()
    if not imgui.tree_node("Motion Explorer") then return end
    if imgui.button("Reset") then init() end
    if not pcall(draw_ui) then
      imgui.text("Failed to render menu")
      log.error("[motion_explorer] Failed to render menu")
    end
    imgui.tree_pop()
  end)
end

main()
