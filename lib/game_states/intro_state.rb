class IntroState < GameState
  
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
      start_game
    end
  end

  def start_game
    $window.state_manager.pop
    $window.state_manager.push GameplayState.new
  end

  def update
    @speaker.update
    @texts.each { |t| t.update }

    unless $window.input_disabled?
      if $window.button_down? Gosu::KbS
        start_game
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
      { "Colonel Freeman" => "... You'll be assiting Cobra Team in this operation. We need you to do \nwhat you do best: provide long-range fire support for Cobra's insertion plan, \ninfiltrate the compound and take out a number of high-value targets." },
      { "You" => "I assume I won't be joining their party." },
      { "Colonel Freeman" => "No, you'll be splitting up from Cobra as soon as the chopper lands. \nDon't expect any support." },
      { "You" => "Fine. I like a little alone time now and then." },
      { "Colonel Freeman" => "The compound features state-of-the-art intruder detection systems. \nAny stray gunfire will put the whole place on alert and could jeopardise Cobra Team. \nPrecision is paramount on this mission." },
      { "You" => "Precision's my middle name." },
      { "Colonel Freeman" => "Remember: shoot to kill. \n\nDon't miss a shot - you only get one. Move out." }
    ]
  end

end 
