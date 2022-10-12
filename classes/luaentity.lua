---@meta

---@class Luaentity
---@field name string
---@field object ObjectRef
---@field on_activate fun(self: Luaentity, staticdata, dtime_s: number)
---@field on_step fun(self: Luaentity, dtime: number, moveresult: moveresult)
---@field on_punch fun(self: Luaentity, puncher: ObjectRef, time_from_last_punch: number, tool_capabilities: tool_capabilities, dir: Vector)
---@field on_rightclick fun(self: Luaentity, clicker: ObjectRef)
---@field get_staticdata fun(self: Luaentity): string
