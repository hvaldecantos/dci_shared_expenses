require './user'
require './expense'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

pizza = adele.paid_expenses.create description: "Pizza"
p pizza
p pizza.payer

p User.all
p Expense.all
