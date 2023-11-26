local gfx <const> = playdate.graphics


---@class _Scene
---@field init fun(args?: any)
---@field update function
---@field bgDraw function
---@field cleanup? function


---@alias _changeScene fun(newScene: string, args?: table<string, any>)

---@param initParams { settings: { get: fun(string): any, set: fun(string): any }, soundManager: SoundManager, scenes: table<string, _Scene> }
function _SceneManager(initParams)
  local currentScene = nil ---@type _Scene?

  local settings = initParams.settings
  local soundManager = initParams.soundManager

  ---@type _changeScene
  local function changeScene(newScene, args)
    gfx.sprite.removeAll()

    if currentScene and currentScene.cleanup then
      currentScene.cleanup()
    end

    if initParams.scenes[newScene] == nil then
      error("Invalid scene: " .. newScene)
    end

    currentScene = initParams.scenes[newScene]({
      changeScene = changeScene,
      settings = settings,
      soundManager = soundManager,
      args = args,
    })
  end

  local function update()
    if currentScene and currentScene.update then
      currentScene.update()
    end
  end


  return {
    changeScene = changeScene,
    update = update,
  }
end
