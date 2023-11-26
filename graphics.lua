local gfx <const> = playdate.graphics


---@param image _Image
---@param cx number?
---@param cy number?
---@return _Sprite
local function initSprite(image, cx, cy)
  local sprite = gfx.sprite.new(image)

  sprite:setCenter(cx or 0, cy or 0)

  return sprite
end


---@param sprite _Sprite
---@param x number
---@param y number
local function addSpriteAt(sprite, x, y)
  sprite:moveTo(x, y)
  sprite:add()

  return sprite
end


---@param params { image: _Image, x: number, y: number }
---@return _Sprite
local function instanceSprite(params)
  local sprite = initSprite(params.image)

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


Graphics = {
  instanceSprite = instanceSprite,
  setBg = setBg,
  drawCenteredText = drawCenteredText,
} ---@type _Graphics
