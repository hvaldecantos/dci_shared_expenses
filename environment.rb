require './user'
require './expense'
require './share'
require './payment'
require './split_expense_context'
require './register_payment_context'
require './print_creditors_context'
require './print_debtors_context'
require './print_balance_context'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterPaymentContext::execute adele.id, [adele.id, dan.id], "Pizza", 14.20
RegisterPaymentContext::execute dan.id, [adele.id, dan.id, alan.id], "Beer", 9.75
RegisterPaymentContext::execute alan.id, [adele.id, dan.id, alan.id], "Tickets", 9.75

p User.all
p Expense.all
p Share.all
p Payment.all

PrintBalanceContext::execute adele.id

PrintBalanceContext::execute dan.id

PrintBalanceContext::execute alan.id
