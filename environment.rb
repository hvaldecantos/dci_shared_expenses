require './db_schema'
require './user'
require './expense'
require './share'
require './payment'
require './split_expense_equally_context'
require './display_debtors_context'
require './display_creditors_context'

adele = User.new(name: "Adele")
dan = User.new(name: "Dan")
alan = User.new(name: "Alan")
adele.save
dan.save
alan.save

pizza = Expense.new(description: "Pizza")
beer = Expense.new(description: "Beer")
pizza.save
beer.save

p User.all
p Expense.all

# sharing a pizza
SplitExpenseEquallyContext::execute pizza.id, [adele.id, dan.id], 14.20

# sharing beer
SplitExpenseEquallyContext::execute beer.id, [adele.id, dan.id, alan.id], 10.00

Share.all.each{|e| puts "#{e.user.name} #{e.expense.description} #{e.amount}"}

adele.payments.create(expense: pizza)
dan.payments.create(expense: beer)

Share.all.each{|e| puts "#{e.user.name} #{e.expense.description} #{e.amount} #{e.expense.payment.user.name}"}

p Payment.all

DisplayDebtorsContext::execute adele.id
puts "-----------"
DisplayCreditorsContext::execute adele.id
