require './user'
require './expense'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

pizza = Expense.create description: "Pizza"
beer = Expense.create description: "Beer"
ticket = Expense.create description: "Ticket"

p User.all
p Expense.all
