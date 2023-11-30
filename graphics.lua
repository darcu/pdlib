local gfx <const> = playdate.graphics

---@param params { image: _Image, cx: number?, cy: number? }
---@return _Sprite
local function initSprite(params)
  local sprite = gfx.sprite.new(params.image)

  sprite:setCenter(params.cx or 0, params.cy or 0)

  return sprite
end


---@param params { sprite: _Sprite, x: number, y: number }
---@return _Sprite
local function addSpriteAt(params)
  params.sprite:moveTo(params.x, params.y)
  params.sprite:add()

  return params.sprite
end


---@param params { image: _Image, x: number, y: number }
---@return _Sprite
local function instanceSprite(params)
  local sprite = initSprite({ image = params.image })

  return addSpriteAt({ sprite = sprite, x = params.x, y = params.y })
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
---@field initSprite fun(params: { image: _Image, cx: number?, cy: number? }): _Sprite
---@field addSpriteAt fun(params: { sprite: _Sprite, x: number, y: number }): _Sprite
---@field instanceSprite fun(params: { image: _Image, x: number, y: number }): _Sprite
---@field setBg fun(bgCallback: function)
---@field drawCenteredText fun(text: string, y: number)
Graphics = {
  initSprite = initSprite,
  addSpriteAt = addSpriteAt,
  instanceSprite = instanceSprite,
  setBg = setBg,
  drawCenteredText = drawCenteredText,
} ---@type _Graphics
