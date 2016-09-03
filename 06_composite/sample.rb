# ベースとなるタスク
class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_time_required
    0.0
  end
end

# 末端のタスク
class AddDryIngredientsTask < Task

  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0 # 小麦粉と卵を混ぜるのに1分
  end
end

# 末端のタスク
class MixTask < Task

  def initialize
    super('Mix that better up!')
  end

  def get_time_required
    3.0 # 混ぜるのに3分
  end
end

# コンポジットクラスのベースクラス
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks.push(task)
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def get_time_required
    @sub_tasks.each_with_object(0) { |task, sum| sum += task.get_time_required }
  end
end

# バターを作るクラス
class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(MixTask.new)
  end
end
