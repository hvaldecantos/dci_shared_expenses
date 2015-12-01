require './user'
require './expense'
require './share'
require './register_shared_expense_payment_context'
require './print_debtors_context'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterSharedExpensePaymentContext::execute adele.id, [adele.id, dan.id], "Pizza", 14.20
# adele.shares.create expense: pizza, amount: 14.20/2.0
# dan.shares.create expense: pizza, amount: 14.20/2.0

RegisterSharedExpensePaymentContext::execute adele.id, [adele.id, dan.id, alan.id], "Beer", 10.00
# adele.shares.create expense: pizza, amount: 10.0/3.0
# dan.shares.create expense: pizza, amount: 10.0/3.0
# alan.shares.create expense: pizza, amount: 10.0/3.0

PrintDebtorsContext::execute adele.id

p User.all
p Expense.all
p Share.all
