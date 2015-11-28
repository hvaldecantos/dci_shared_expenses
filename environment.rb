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

# sharing a pizza, beer, and tickets
SplitExpenseEquallyContext::execute pizza.id, [adele.id, dan.id], 14.20
adele.payments.create(expense: pizza)
# adele: dan 7.1

SplitExpenseEquallyContext::execute beer.id, [adele.id, dan.id, alan.id], 10.00
dan.payments.create(expense: beer)
dan.payments.create(expense: beer)
# dan: adele -7.1 + 3.33 + 3.33 = -0.44, alan 3.34 + 3.34 = 6.68

SplitExpenseEquallyContext::execute ticket.id, [adele.id, dan.id, alan.id], 30.00
alan.payments.create(expense: ticket)
# alan: adele 10, dan -6.68 + 10 = 3.32

RegisterEquallySharedExpensePaymentContext::execute alan.id, "Taxy ride", [adele.id, dan.id, alan.id], 23.00
# alan: adele 10 + 7.67 = 17.67, dan 3.32 + 7.67 = 10.99

puts "adele balance ----------"
DisplayBalanceContext::execute adele.id
puts "dan balance ------------"
DisplayBalanceContext::execute dan.id
puts "alan balance -----------"
DisplayBalanceContext::execute alan.id

DisplayReportContext::execute adele.id
DisplayReportContext::execute dan.id
DisplayReportContext::execute alan.id
