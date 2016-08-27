# 共通で使えるオブザーバ用のmoduleを定義(コードブロック版)
module Subject
  def initialize
    @observers = []
  end

  def add_observer(&observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.call(self)
    end
  end
end

# moduleを使ってクラスを定義
class Employee
  include Subject

  attr_reader :name, :address
  attr_reader :salary

  def initialize(name, address, salary)
    super()
    @name = name
    @address = address
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

fred = Employee.new('Fred', 'Crane Operator', 30000.0)
fred.add_observer do |changed_employee|
  puts("#{changed_employee.name}は昇級しました！")
  puts("新しい給料は#{changed_employee.salary}です")
end
fred.salary = 35000.0
