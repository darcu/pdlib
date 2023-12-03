local snd = playdate.sound


---@alias SoundManager { play: fun(name: string) }

---@param sounds table<string, string>
function _SoundManager(sounds)
  local samples = {}

  for key, path in pairs(sounds) do
    samples[path] = snd.sampleplayer.new(path)
  end

  return {
    play = function(name)
      samples[name]:play(1)
    end,
  }
end
