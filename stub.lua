---@meta

---@class PD
---@field BUTTONS table<string, string>
---@field SCREEN_WIDTH number
---@field SCREEN_HEIGHT number
PD = {}

---@class _Graphics
---@field instanceSprite fun(params: { image: _Image, x: number, y: number }): _Sprite
---@field setBg fun(bgCallback: function)
---@field drawCenteredText fun(text: string, y: number)
Graphics = {}
