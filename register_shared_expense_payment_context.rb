require './context_accessor'
require './user'
require './expense'
require './payer_role'

class RegisterSharedExpensePaymentContext
  attr_reader :payer, :participants, :expense, :total_amount
  include ContextAccessor

  def self.execute(user_id, user_ids, expense_description, total_amount)
    RegisterSharedExpensePaymentContext.new(user_id, user_ids, expense_description, total_amount).execute
  end

  def initialize(user_id, user_ids, expense_description, total_amount)
    @payer = User.find(user_id).extend PayerRole
    @participants = user_ids
    @expense = Expense.create(description: expense_description)
    @total_amount = total_amount
  end

  def execute
    execute_in_context do
      payer.record_payment
    end
  end
end
