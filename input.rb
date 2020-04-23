class Input
  include Gosu

  BUTTON_MAP = {
    KbSpace => :jump,
    # KbDown  =>
    # KbUp    =>
    KbLeft  => [:move, :left],
    KbRight => [:move, :right],
  }.freeze
  # Gosu::KbDown
  # Gosu::KbUp
  # Gosu::KbLeft
  # Gosu::KbRight

  def initialize(player)
    @player = player
  end

  def buttons_held
    buttons = BUTTON_MAP.keys.select { |key| button_down?(key) }
    button_down(buttons)
  end

  def button_down(buttons)
    actions(buttons).each do |action|
      @player.send(*action)
    end
  end

  def button_up(buttons)
    actions(buttons).each do |action|
      action_method = "un_#{Array(action).first}" # dropping args
      @player.send(action_method) if @player.respond_to?(action_method)
    end
  end

  private

  def actions(buttons)
    puts buttons
    BUTTON_MAP.values_at(*buttons).dup.compact
  end

  def update(button_ups)
    return
    BUTTON_MAP.each do |button, action|
      @player.send(*action) if button_down?(button)
    end

    BUTTON_MAP.each do |button, *action|
      action_method = "un_#{action.shift}" # dropping the rest of the args here.  don't need them yet

      if button_ups && button_ups.include?(button)
        @player.send(action_method) if @player.respond_to?(action_method)
      end
    end
  end
end

