---@alias _Settings fun(): table


---@param settings table
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
