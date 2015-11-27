require './db_schema'
require './user'
require './expense'
require './share'
require './payment'
require './split_expense_equally_context'

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
adele.shares.create(expense: pizza,amount: 7.10)
Share.create(user: dan, expense: pizza,amount: 7.10)

# sharing beer
SplitExpenseEquallyContext::execute beer.id, [adele.id, dan.id, alan.id], 10.00
# adele.shares.create(expense: beer, amount: 3.25)
# dan.shares.create(expense: beer, amount: 3.25)
# alan.shares.create(expense: beer, amount: 3.25)

Share.all.each{|e| puts "#{e.user.name} #{e.expense.description} #{e.amount}"}

adele.payments.create(expense: pizza)
dan.payments.create(expense: beer)

Share.all.each{|e| puts "#{e.user.name} #{e.expense.description} #{e.amount} #{e.expense.payment.user.name}"}

p Payment.all
