require './context_accessor'
require './registrar_role'
require './expense'
require './user'

class RegisterSharedExpensePaymentContext
  attr_reader :registrar, :participants, :expense, :total_amount
  include ContextAccessor

  def self.execute(user_id, user_ids, expense_description, total_amount)
    RegisterSharedExpensePaymentContext.new(user_id, user_ids, expense_description, total_amount).execute
  end

  def initialize(user_id, user_ids, expense_description, total_amount)
    @registrar = User.find(user_id).extend RegistrarRole
    @participants = user_ids
    @expense = Expense.create(description: expense_description)
    @total_amount = total_amount
  end

  def execute
    execute_in_context do
      registrar.record_payment
    end
  end
end
