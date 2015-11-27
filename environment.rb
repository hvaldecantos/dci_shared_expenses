require './db_schema'
require './user'
require './expense'

User.new(name: "Adele").save
User.new(name: "Dan").save
User.new(name: "Alan").save

Expense.new(description: "Pizza", amount: 14.20).save
Expense.new(description: "Beer", amount: 9.75).save

p User.all
p Expense.all
