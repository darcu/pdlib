import "soundManager"

local gfx <const> = playdate.graphics


---@class Scene
---@field update fun(manager: SceneManager)
---@field cleanup? function

---@alias _Scene fun(manager: SceneManager, args?: table<string, any>): Scene

---@class SceneManager
---@field currentScene Scene
---@field settings table<string, any>
---@field soundManager SoundManager
---@field update fun(self: SceneManager)
---@field changeScene fun(self: SceneManager, newScene: string, args?: table<string, any>)


---@class InitParams
---@field settings table<string, any>
---@field sounds table<string, string>
---@field _scenes table<string, _Scene>

---@param initParams InitParams
---@return SceneManager
function _SceneManager(initParams)
  return {
    currentScene = nil,
    settings = initParams.settings,
    soundManager = _SoundManager(initParams.sounds),
    update = function(self)
      if self.currentScene and self.currentScene.update then
        self.currentScene.update()
      end
    end,
    changeScene = function(self, newScene, args)
      gfx.sprite.removeAll()

      if self.currentScene and self.currentScene.cleanup then
        self.currentScene.cleanup()
      end

      if initParams._scenes[newScene] == nil then
        error("Invalid scene: " .. newScene)
      end

      self.currentScene = initParams._scenes[newScene](self, args)
    end,
  }
end
