require './create_expense_context'
require './split_expense_context'
require './user'
require './share'
require './expense'
require './payment'

User.new(name: "Adele").save
CreateExpenseContext::execute 1, "Rent"

u1 = User.new name: "hector"
u2 = User.new name: "adrian"
e = Expense.new description: "renta"

u1.save
u2.save
e.save

SplitExpenseContext::execute 1, 1, {1 => 1250.0, 2 => 50.25}

Payment.new(user_id: 2, expense_id: 1).save

puts "--------------"
p User.all
p Expense.all
p Share.all
p Payment.all
puts "--------------"
