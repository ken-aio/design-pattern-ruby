# 共通で使えるオブザーバ用のmoduleを定義
module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
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

# 購読者を定義
class TaxMan
  def update(changed_employee)
    puts("#{changed_employee.name}に新しい請求書を送ります")
  end
end

tax_man = TaxMan.new
fred = Employee.new('Fred', 'Crane Operator', 30000.0)
fred.add_observer(tax_man)
fred.salary = 35000.0
