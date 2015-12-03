require './user'
require './expense'
require './share'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

pizza = Expense.create description: "Pizza"
beer = Expense.create description: "Beer"
ticket = Expense.create description: "Ticket"

p User.all
p Expense.all

adele.shares.create(expense: pizza, amount: 7.10)
Share.create(user: dan, expense: pizza, amount: 7.10)

p Share.all
