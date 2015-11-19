require './create_expense_context'
require './split_expense_context'
require './account_debtors_context'
require './user'
require './share'
require './expense'
require './payment'

User.new(name: "Adele").save
CreateExpenseContext::execute 1, "Rent" # => This context is not very useful

u2 = User.new name: "hector"
u3 = User.new name: "adrian"
e2 = Expense.new description: "Beer"    # => Instead of using the context
e3 = Expense.new description: "Food"
e4 = Expense.new description: "Table"
e5 = Expense.new description: "Unpaid"

u2.save
u3.save
e2.save
e3.save
e4.save
e5.save

SplitExpenseContext::execute 1, 1, {1 => 1250.0, 2 => 50.25}
SplitExpenseContext::execute 1, 2, {1 => 10.1, 2 => 10.1, 3 => 10.1}
SplitExpenseContext::execute 1, 3, {1 => 3.3, 2 => 3.3, 3 => 3.3}
SplitExpenseContext::execute 1, 4, {1 => 4.4, 3 => 4.4}

Payment.new(user_id: 2, expense_id: 1).save
Payment.new(user_id: 1, expense_id: 2).save
Payment.new(user_id: 2, expense_id: 3).save
Payment.new(user_id: 2, expense_id: 4).save

puts "--------------"
p User.all
p Expense.all
p Share.all
p Payment.all
puts "--------------"

AccountDebtorsContext::execute 2
