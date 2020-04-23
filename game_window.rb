require 'gosu'
require 'pry'

class GameWindow < Gosu::Window
  def initialize(x = 800, y = 600)
    super(x, y)
    self.caption = "mr unicorn vs the balloons"

    @player = Player.new
    @input = Input.new(@player)
  end

  def button_up(*args)
    @input.button_up args
  end

  def update
    # @player.update

    # Input.new(@player).button_down(@button_ups)
    Input.new(@player).buttons_held

    # gravity is observable, asks all subscribers to update selves
    # update_gravity

    # gravity is observable.  asks all subscribers to schedule their gravity tasks.
    # this is a little circuitous, but if each iunstance schedules itself, nothing should be left dangling
    schedule_tasks.perform_all
  end

  def draw
    @player.draw
  end

  private

  # def update_gravity
  #   GameRules::Gravity.update_all
  # end


  def schedule_tasks
    FrameTasks.new.tap do |tasks|
      GameRules::Gravity.schedule(tasks)
      GameRules::Velocity.schedule(tasks)
      GameRules::TerminalVelocity.schedule(tasks)
      GameRules::Floor.schedule(tasks)
    end
  end
end
