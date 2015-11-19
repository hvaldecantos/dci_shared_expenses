require './create_expense_context'
require './split_expense_context'
require './user'
require './share'
require './expense'

User.new(name: "Adele").save
CreateExpenseContext::execute 1, "Rent", 1300.25

u1 = User.new name: "hector"
u2 = User.new name: "adrian"
e = Expense.new description: "renta", amount: 100.50

u1.save
u2.save
e.save

SplitExpenseContext::execute 1, 1, {1 => 1250.0, 2 => 50.25}

puts "--------------"
p User.all
p Expense.all
p Share.all
puts "--------------"
