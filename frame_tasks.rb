# all tasks in one frame
class FrameTasks
  class Task
    # this task works for single entities.  hwo will it do collisions?
    # coudl collisions be one direction?  when it happens, BOTH events run
    def initialize(rule:, entity:)
      @rule = rule
      @entity = entity
    end

    def call
      # rule is a module
      # entity is an object
      @rule.update @entity
      # any way to make this less mutatey?
    end
  end

  def initialize
    @tasks = []
  end

  def add(rule, entity)
    @tasks << Task.new(rule: rule, entity: entity)
  end

  def perform_all
    @tasks.each(&:call)
  end

  private

  # def priority?
end
