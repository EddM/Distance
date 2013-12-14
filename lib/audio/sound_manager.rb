#
# Preload all available sounds and queue them up for playback
# without delay.
#
class SoundManager
    
  def initialize
    @sounds = Dir["res/*.wav"].map do |file|
      name = file.split("/")[1].split(".")[0]
      [name.to_sym, Gosu::Sample.new($window, file)]
    end

    @sounds, @playing_sounds = Hash[*@sounds.flatten], {}
  end
  
  # Play a given sound, optionally do not play the sound if it is already playing
  def play!(name, exclusive = true, volume = 1.0)
    return if $mute
    name = name.to_sym
    
    if exclusive
      unless @playing_sounds[name] && @playing_sounds[name].playing?
        @playing_sounds[name] = @sounds[name].play(volume)
      end
    else
      @sounds[name].play(volume)
    end
  end
  
end
