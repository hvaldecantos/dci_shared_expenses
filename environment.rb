require './user'
require './expense'
require './share'
require './register_shared_expense_payment_context'
require './print_debtors_context'
require './print_creditors_context'
require './print_balance_context'
require './print_report_context'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

RegisterSharedExpensePaymentContext::execute adele.id, [adele.id, dan.id], "Pizza", 14.20
RegisterSharedExpensePaymentContext::execute dan.id, [adele.id, dan.id, alan.id], "Beer", 10.00
RegisterSharedExpensePaymentContext::execute alan.id, [adele.id, dan.id, alan.id], "Ticket", 23.00
RegisterSharedExpensePaymentContext::execute dan.id, [adele.id, dan.id, alan.id], "Beer", 10.00
RegisterSharedExpensePaymentContext::execute alan.id, [adele.id, dan.id, alan.id], "Taxy ride", 24.00

PrintBalanceContext::execute adele.id
PrintBalanceContext::execute dan.id
PrintBalanceContext::execute alan.id

PrintReportContext::execute adele.id
