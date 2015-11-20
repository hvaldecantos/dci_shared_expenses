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
User.new(name: "Hector").save
User.new(name: "Alan").save

adele_id = 1
hector_id = 2
alan_id = 3

Expense.new(description: "Beer").save
Expense.new(description: "Pizza").save
Expense.new(description: "Tickets").save

beer_expense_id = 1
pizza_expense_id = 2
tickets_expense_id = 3

SplitExpenseContext::execute 1, beer_expense_id, {adele_id => 3.25, hector_id => 3.25, alan_id => 3.25}
SplitExpenseContext::execute 1, pizza_expense_id, {adele_id => 7.10, hector_id => 7.10}
SplitExpenseContext::execute 1, tickets_expense_id, {adele_id => 5.70, hector_id => 5.70, alan_id => 5.70}

Payment.new(user_id: hector_id, expense_id: beer_expense_id).save
Payment.new(user_id: adele_id, expense_id: pizza_expense_id).save
Payment.new(user_id: hector_id, expense_id: beer_expense_id).save
Payment.new(user_id: alan_id, expense_id: tickets_expense_id).save
Payment.new(user_id: hector_id, expense_id: beer_expense_id).save

RegisterSharedExpensePaymentContext::execute adele_id, "Taxi ride", {adele_id => 2.1, alan_id => 2.1}

puts "Adele balance --------------"
ComputeBalanceContext::execute adele_id
puts "Hector balance -------------"
ComputeBalanceContext::execute hector_id
puts "Alan balance ---------------"
ComputeBalanceContext::execute alan_id

Expense.new(description: "Payback").save
SplitExpenseContext::execute 1, 4, {hector_id => 4.05}
Payment.new(user_id: alan_id, expense_id: 4).save

Settlement.new(user_id: adele_id, creditor_id: hector_id, amount: 2.65).save

puts
puts "Adele balance --------------"
ComputeBalanceContext::execute adele_id
puts "Hector balance -------------"
ComputeBalanceContext::execute hector_id
puts "Alan balance ---------------"
ComputeBalanceContext::execute alan_id

puts "Receive debt settlements ------------"
AccountReceivedSettlementsContext::execute hector_id
puts "Provided debt settlements --------"
AccountProvidedSettlementsContext::execute adele_id
