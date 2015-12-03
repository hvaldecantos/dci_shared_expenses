require './user'
require './expense'
require './share'
require './payment'
require './register_payment_context'
require './print_balance_context'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterPaymentContext::execute adele.id, [adele.id, dan.id], "Pizza", 14.20
RegisterPaymentContext::execute dan.id, [adele.id, dan.id, alan.id], "Beer", 9.75
RegisterPaymentContext::execute alan.id, [adele.id, dan.id, alan.id], "Tickets", 9.75

PrintBalanceContext::execute adele.id
PrintBalanceContext::execute dan.id
PrintBalanceContext::execute alan.id
