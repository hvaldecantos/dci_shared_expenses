require './create_expense_context'
require './split_expense_context'
require './account_debtors_context'
require './account_creditors_context'
require './user'
require './share'
require './expense'
require './payment'
require './settlement'

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

p1 = Payment.new(user_id: 2, expense_id: 1)
p2 = Payment.new(user_id: 1, expense_id: 2)
p3 = Payment.new(user_id: 2, expense_id: 3)
p4 = Payment.new(user_id: 2, expense_id: 4)
p1.save
p2.save
p3.save
p4.save

puts "--------------"
p User.all
p Expense.all
p Share.all
p Payment.all
puts "--------------"

AccountDebtorsContext::execute 2
AccountCreditorsContext::execute 2

s1 = Settlement.new(user_id: 1, creditor_id: 2, amount: 10.1)
s2 = Settlement.new(user_id: 1, creditor_id: 2, amount: 57.7)
s1.save
s2.save

puts "------------"
p s1.creditor.received_settlements
