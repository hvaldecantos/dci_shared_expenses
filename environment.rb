require './db_schema'
require './user'
require './expense'
require './share'
require './payment'

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
adele.shares.create(expense: beer, amount: 3.25)
dan.shares.create(expense: beer, amount: 3.25)
alan.shares.create(expense: beer, amount: 3.25)

p Share.all

adele.payments.create(expense: pizza)
dan.payments.create(expense: beer)

p Payment.all
