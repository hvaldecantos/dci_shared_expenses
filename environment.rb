require './user'
require './expense'
require './share'
require './payment'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

pizza = Expense.create description: "Pizza"
beer = Expense.create description: "Beer"
ticket = Expense.create description: "Ticket"

p User.all
p Expense.all

# sharing a pizza
adele.shares.create(expense: pizza, amount: 7.10)
Share.create(user: dan, expense: pizza, amount: 7.10)

# sharing beer
adele.shares.create(expense: beer, amount: 3.25)
dan.shares.create(expense: beer, amount: 3.25)
alan.shares.create(expense: beer, amount: 3.25)

p Share.all

# making payments
adele.payments.create(expense: pizza)
dan.payments.create(expense: beer)

p Payment.all
