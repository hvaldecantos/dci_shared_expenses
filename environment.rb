require './user'
require './expense'
require './share'
require './payment'
require './split_expense_context'
require './register_shared_expense_payment_context'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterSharedExpensePaymentContext::execute adele.id, [adele.id, dan.id], "Pizza", 14.20
RegisterSharedExpensePaymentContext::execute dan.id, [adele.id, dan.id, alan.id], "Beer", 9.75
RegisterSharedExpensePaymentContext::execute alan.id, [adele.id, dan.id, alan.id], "Tickets", 9.75

p User.all
p Expense.all
p Share.all
p Payment.all
