require './user'
require './expense'
require './share'
require './payment'
require './split_expense_context'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

pizza = Expense.create description: "Pizza"
beer = Expense.create description: "Beer"
ticket = Expense.create description: "Ticket"

p User.all
p Expense.all

# sharing a pizza
SplitExpenseContext::execute pizza.id, [adele.id, dan.id], 14.20

# sharing beer
SplitExpenseContext::execute beer.id, [adele.id, dan.id, alan.id], 9.75

p Share.all

# making payments
adele.payments.create(expense: pizza)
dan.payments.create(expense: beer)

p Payment.all
