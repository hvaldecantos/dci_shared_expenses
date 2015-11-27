require './db_schema'
require './user'
require './expense'
require './share'

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

adele.shares.create(expense: pizza,amount: 7.10)
Share.create(user: dan, expense: pizza,amount: 7.10)

p Share.all
