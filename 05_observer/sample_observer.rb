require 'observer'

# moduleを使ってクラスを定義
class Employee
  include Observable

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
    changed
    notify_observers(self)
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
