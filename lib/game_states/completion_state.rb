class CompletionState < GameState

  def initialize
    @step = 0
    @data = message_data
    build_text
  end

  def build_text
    TextTyper.type_locked = nil
    @speaker = TextTyper.new(100, 100, "#{@data[@step].keys.first}:", $window.big_font)
    texts = @data[@step].values.first.split("\n")
    y_offset = 150
    @texts = texts.map do |text|
      tt = TextTyper.new(100, y_offset, text)
      y_offset += 25
      tt
    end
  end

  def next_step
    @step += 1

    unless @step >= @data.size
      build_text
    else
      back_to_menu
    end
  end

  def back_to_menu
    $window.state_manager.pop
    $window.state_manager.push MenuState.new
  end

  def update
    @speaker.update
    @texts.each { |t| t.update }

    unless $window.input_disabled?
      if $window.button_down? Gosu::KbS
        back_to_menu
        $input_disabled = 50
      end

      if $window.button_down? Gosu::MsLeft
        next_step
        $input_disabled = 50
      end
    end
  end

  def draw
    @speaker.draw
    @texts.each { |t| t.draw }
    $window.font.draw "Click to skip ahead", $window.width - 200, $window.height - 50, Z::UI
  end

  private

  def message_data
    [
      { "Colonel O'Shea" => "Good work, soldier. Unfortunately, the developer didn't have time \nto create any more levels, so that's it." },
      { "You" => "That lazy bum." },
      { "Colonel O'Shea" => "Well he only had 48 hours. I think he's done a pretty good job.\nThat last level was hard, huh?" },
      { "You" => "Only 48 hours? Well, I stand corrected. He did a great job." },
      { "Colonel O'Shea" => "Damn straight. Be sure to rate Distance on LudumDare.com and let \nEdd know what you thought of the game!" },
      { "You" => "I will. I heard you can find him on Twitter as @eddm, right?" },
      { "Colonel O'Shea" => "Affirmative. Thanks for playing!" }
    ]
  end

end
