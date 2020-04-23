class Player
  extend Forwardable
  include Observable

  prepend ::GameRules::Gravity::Initializer
  prepend ::GameRules::Velocity::Initializer
  prepend ::GameRules::TerminalVelocity::Initializer
  prepend ::GameRules::Floor::Initializer

  attr_reader :coordinates
  def_delegators :@coordinates,
    :x, :y, :a, :vel_x, :vel_y, :vel_a

  def initialize
    @coordinates = Coordinates.new x: 50.0, y: 60.0, a: 0.0, vel_x: 0, vel_y: 0, vel_a: 0
    # @image = Gosu::Image.new("assets/sprites/unicorn-sprite.png")
    @sprites = Gosu::Image.load_tiles("assets/sprites/unicorn-sprite.png", 150, 120)
    # @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def terminal_velocity
    2
  end

  def schedule_task(frame_tasks, game_rule)
    frame_tasks.add game_rule, self
  end

  def un_move
    @walking = false
  end

  def move(direction)
    @walking = true
    @facing = direction

    movement = if direction == :right
      5
    elsif direction == :left
      -5
    end

    coordinates.x += movement
  end

  def jump
    coordinates.vel_y -= 10 unless @jumping
    @jumping = true
  end

  def un_jump
    @jumping = false
  end


  def draw
    standing = @sprites.first
    jumping = @sprites.last
    alternating = (Gosu::milliseconds / 100).even? ? standing : jumping

    image = case movement
    when :standing then standing
    when :jumping then jumping
    when :falling then alternating
    when :walking then alternating
    end

    image.draw_rot(x, y, 1, a, 0.5, 0.5, facing_scale, 1)
  end

  def facing_scale
    @facing == :left ? -1 : 1
  end


  private

  def movement
    if y == 450
      return :walking if @walking
      :standing
    else
      return :jumping if @jumping
      :falling
    end
  end
end

__END__

  def jump
    @vel_y += 5.0
    @vel_y = [7.5, @vel_y].min
    puts 'jump'
  end

  # def update
  #   binding.pry
  #   @vel_y -= 1.0
  #   @y = @y + @vel_y
  #   @y = [0, @y].max
  #   if @y == 0.0
  #     @vel_y = 0.0
  #   end
  # end



  def update_gravity(game_rule)
    game_rule.update_entity self

    # @y = @y - vel_alue
    # puts 'updating gracity'
    # binding.pry
  end
end

__END__

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.5)
    @vel_y += Gosu.offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
