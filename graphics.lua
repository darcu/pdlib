local gfx <const> = playdate.graphics

---@param image _Image
---@param cx? number
---@param cy? number
---@return _Sprite
local function initSprite(image, cx, cy)
  local sprite = gfx.sprite.new(image)

  sprite:setCenter(cx or 0, cy or 0)

  return sprite
end


---@param sprite _Sprite
---@param x? number
---@param y? number
---@return _Sprite
local function addSpriteAt(sprite, x, y)
  sprite:moveTo(x or 0, y or 0)
  sprite:add()

  return sprite
end


---@param params { image: _Image, x?: number, y?: number, cx?: number, cy?: number }
---@return _Sprite
local function instanceSprite(params)
  local sprite = initSprite(params.image, params.cx, params.cy)

  return addSpriteAt(sprite, params.x, params.y)
end


local bgSprite = nil ---@type _Sprite?

---@param bgCallback function
local function setBg(bgCallback)
  if bgSprite then
    bgSprite:remove()
  end

  bgSprite = gfx.sprite.setBackgroundDrawingCallback(bgCallback)
end


---@param text string
---@param y number
local function drawCenteredText(text, y)
  gfx.drawTextAligned(text, 200, y, kTextAlignment.center)
end


---@class _Graphics
---@field instanceSprite fun(params: { image: _Image, x: number, y: number }): _Sprite
---@field setBg fun(bgCallback: function)
---@field drawCenteredText fun(text: string, y: number)
Graphics = {
  instanceSprite = instanceSprite,
  setBg = setBg,
  drawCenteredText = drawCenteredText,
} ---@type _Graphics
