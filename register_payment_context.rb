require './context_accessor'
require './user'
require './expense'
require './payer_role'

class RegisterPaymentContext
  attr_reader :payer, :payee_ids, :expense, :total_amount
  include ContextAccessor

  def self.execute(user_id, user_ids, expense_description, total_amount)
    RegisterPaymentContext.new(user_id, user_ids, expense_description, total_amount).execute
  end

  def initialize(user_id, user_ids, expense_description, total_amount)
    @payer = User.find(user_id).extend PayerRole
    @payee_ids = user_ids
    @expense = Expense.create(description: expense_description)
    @total_amount = total_amount
  end

  def execute
    execute_in_context do
      payer.record_payment
    end
  end
end
