require './create_expense_context'
require './split_expense_context'
require './account_debtors_context'
require './account_creditors_context'
require './account_received_settlements_context'
require './account_provided_settlements_context'
require './compute_balance_context'
require './register_shared_expense_payment_context'
require './user'
require './share'
require './expense'
require './payment'
require './settlement'

User.new(name: "Adele").save
User.new(name: "Dan").save
User.new(name: "Alan").save

adele_id = 1
dan_id = 2
alan_id = 3

Expense.new(description: "Beer").save
Expense.new(description: "Pizza").save
Expense.new(description: "Tickets").save

beer_expense_id = 1
pizza_expense_id = 2
tickets_expense_id = 3

# SplitExpenseContext::execute 1, beer_expense_id, {adele_id => 3.25, dan_id => 3.25, alan_id => 3.25}
# SplitExpenseContext::execute 1, pizza_expense_id, {adele_id => 7.10, dan_id => 7.10}
# SplitExpenseContext::execute 1, tickets_expense_id, {adele_id => 5.70, dan_id => 5.70, alan_id => 5.70}

# Payment.new(user_id: dan_id, expense_id: beer_expense_id).save
# Payment.new(user_id: adele_id, expense_id: pizza_expense_id).save
# Payment.new(user_id: dan_id, expense_id: beer_expense_id).save
# Payment.new(user_id: alan_id, expense_id: tickets_expense_id).save
# Payment.new(user_id: dan_id, expense_id: beer_expense_id).save

RegisterSharedExpensePaymentContext::execute dan_id, "Beer 1", {adele_id => 3.25, dan_id => 3.25, alan_id => 3.25}
RegisterSharedExpensePaymentContext::execute adele_id, "Pizza", {adele_id => 7.10, dan_id => 7.10}
RegisterSharedExpensePaymentContext::execute dan_id, "Beer 2", {adele_id => 3.25, dan_id => 3.25, alan_id => 3.25}
RegisterSharedExpensePaymentContext::execute alan_id, "Tickets", {adele_id => 5.70, dan_id => 5.70, alan_id => 5.70}
RegisterSharedExpensePaymentContext::execute dan_id, "Beer 3", {adele_id => 3.25, dan_id => 3.25, alan_id => 3.25}
RegisterSharedExpensePaymentContext::execute adele_id, "Taxi ride", {adele_id => 2.1, alan_id => 2.1}

# dan -> adele 9.75 => adele debe dan 2.65 
# dan -> alan  9.75 => alan  debe dan 4.05
# adele -> dan 7.10 
# adele -> alan 0.0 
# alan -> dan  5.70 => adele debe alan 5.7 - 2.1 = 3.6
# alan -> adele 5.70

puts "Adele balance --------------"
ComputeBalanceContext::execute adele_id
puts "Dan balance -------------"
ComputeBalanceContext::execute dan_id
puts "Alan balance ---------------"
ComputeBalanceContext::execute alan_id

payback = Expense.new(description: "Payback")
payback.save
SplitExpenseContext::execute 1, payback.id, {dan_id => 4.05}
Payment.new(user_id: alan_id, expense_id: payback.id).save

# Settlement.new(user_id: adele_id, creditor_id: dan_id, amount: 2.65).save

# puts
puts "Adele balance --------------"
ComputeBalanceContext::execute adele_id
puts "Dan balance -------------"
ComputeBalanceContext::execute dan_id
puts "Alan balance ---------------"
ComputeBalanceContext::execute alan_id

# puts "Receive debt settlements ------------"
# AccountReceivedSettlementsContext::execute dan_id
# puts "Provided debt settlements --------"
# AccountProvidedSettlementsContext::execute adele_id
