import "settings"
import "soundManager"

local gfx <const> = playdate.graphics


---@class _Scene
---@field init fun(args?: any)
---@field update function
---@field bgDraw function
---@field cleanup? function

---@class _SceneManager
---@field currentScene _Scene
---@field settings { get: fun(string): any, set: fun(string): any }
---@field soundManager SoundManager
---@field update fun(self: _SceneManager)
---@field changeScene fun(self: _SceneManager, newScene: string, args?: table<string, any>)


---@class InitParams
---@field settings Settings
---@field sounds table<string, string>
---@field scenes table<string, _Scene>

---@param initParams InitParams
function _SceneManager(initParams)
  return {
    currentScene = nil,
    settings = _Settings(initParams.settings),
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

      if initParams.scenes[newScene] == nil then
        error("Invalid scene: " .. newScene)
      end

      self.currentScene = initParams.scenes[newScene](self, args)
    end,
  }
end
