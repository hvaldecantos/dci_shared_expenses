require './user'
require './expense'
require './share'


adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

pizza = adele.paid_expenses.create description: "Pizza"

adele.shares.create expense: pizza, amount: 14.20/2.0
dan.shares.create expense: pizza, amount: 14.20/2.0

p pizza.users

beer = dan.paid_expenses.create description: "Beer"

adele.shares.create expense: pizza, amount: 10.0/3.0
dan.shares.create expense: pizza, amount: 10.0/3.0
alan.shares.create expense: pizza, amount: 10.0/3.0

p User.all
p Expense.all
p Share.all
