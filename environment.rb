require './db_schema'
require './user'
require './expense'
require './share'
require './payment'
require './split_expense_equally_context'
require './display_debtors_context'
require './display_creditors_context'
require './display_balance_context'

adele = User.new(name: "Adele")
dan = User.new(name: "Dan")
alan = User.new(name: "Alan")
adele.save
dan.save
alan.save

pizza = Expense.new(description: "Pizza")
beer = Expense.new(description: "Beer")
ticket = Expense.new(description: "Ticke")
pizza.save
beer.save
ticket.save

# sharing a pizza, beer, and tickets
SplitExpenseEquallyContext::execute pizza.id, [adele.id, dan.id], 14.20
SplitExpenseEquallyContext::execute beer.id, [adele.id, dan.id, alan.id], 10.00
SplitExpenseEquallyContext::execute ticket.id, [adele.id, dan.id, alan.id], 30.00

# making payments
adele.payments.create(expense: pizza)
dan.payments.create(expense: beer)
alan.payments.create(expense: ticket)

puts "adele debtors -----------"
DisplayDebtorsContext::execute adele.id
puts "adele creditors ---------"
DisplayCreditorsContext::execute adele.id
puts "adele balance --_--------"
DisplayBalanceContext::execute adele.id
