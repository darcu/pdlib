local snd = playdate.sound


---@alias SoundManager { play: fun(name: string) }

---@param sounds table<string, string>
function _SoundManager(sounds)
  local samples = {}

  for key, fileName in pairs(sounds) do
    samples[fileName] = snd.sampleplayer.new('sfx/' .. fileName)
  end

  return {
    play = function(name)
      samples[name]:play(1)
    end,
  }
end
