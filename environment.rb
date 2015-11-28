require './db_schema'
require './user'
require './expense'
require './share'
require './payment'
require './split_expense_equally_context'
require './display_debtors_context'
require './display_creditors_context'
require './display_balance_context'
require './register_equally_shared_expense_payment_context'
require './display_report_context'

adele = User.new(name: "Adele")
dan = User.new(name: "Dan")
alan = User.new(name: "Alan")
adele.save; dan.save; alan.save

pizza = Expense.new(description: "Pizza")
beer = Expense.new(description: "Beer")
ticket = Expense.new(description: "Ticket")
pizza.save; beer.save; ticket.save

# sharing a pizza
SplitExpenseEquallyContext::execute pizza.id, [adele.id, dan.id], 14.20
adele.payments.create(expense: pizza)
# adele: dan 7.1

# sharing beers
SplitExpenseEquallyContext::execute beer.id, [adele.id, dan.id, alan.id], 10.00
dan.payments.create(expense: beer)
dan.payments.create(expense: beer)
# dan: adele -7.1 + 3.33 + 3.33 = -0.44, alan 3.34 + 3.34 = 6.68

# sharing tickets
SplitExpenseEquallyContext::execute ticket.id, [adele.id, dan.id, alan.id], 30.00
alan.payments.create(expense: ticket)
# alan: adele 10, dan -6.68 + 10 = 3.32

# sharing a taxy ride
RegisterEquallySharedExpensePaymentContext::execute alan.id, "Taxy ride", [adele.id, dan.id, alan.id], 23.00
# alan: adele 10 + 7.67 = 17.67, dan 3.32 + 7.67 = 10.99

DisplayReportContext::execute adele.id
DisplayBalanceContext::execute adele.id

DisplayReportContext::execute dan.id
DisplayBalanceContext::execute dan.id

DisplayReportContext::execute alan.id
DisplayBalanceContext::execute alan.id
