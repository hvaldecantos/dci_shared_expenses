require './context_accessor'
require './user'
require './expense'
require './payer_role'
require './payee_role'

class RegisterSharedExpensePaymentContext
  attr_reader :payer, :payees, :expense, :partial_amount
  include ContextAccessor

  def self.execute(user_id, user_ids, expense_description, total_amount)
    RegisterSharedExpensePaymentContext.new(user_id, user_ids, expense_description, total_amount).execute
  end

  def initialize(user_id, user_ids, expense_description, total_amount)
    @payer = User.find(user_id).extend PayerRole
    @payees = user_ids.map{|user_id| User.find(user_id).extend PayeeRole}
    @expense = Expense.create(description: expense_description)
    @partial_amount = (total_amount / payees.size).round(2)
  end

  def execute
    execute_in_context do
      payer.record_made_payment
      payees.each{|payee| payee.record_received_payment}
    end
  end
end
