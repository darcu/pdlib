---@alias Settings { get: fun(key: string), set: fun(key: string, value: any) }
---@alias _Settings fun(): table


---@param settings table
---@return Settings
function _Settings(settings)
  return {
    get = function(key)
      return settings[key]
    end,
    set = function(key, value)
      settings[key] = value
    end
  }
end
