require './context_accessor'
require './registrar_role'
require './expense'
require './user'

class RegisterEquallySharedExpensePaymentContext
  attr_reader :people, :expense, :payer, :total_amount
  include ContextAccessor

  def self.execute(user_id, expense_description, user_ids, total_amount)
    RegisterEquallySharedExpensePaymentContext.new(user_id, expense_description, user_ids, total_amount).execute
  end

  def initialize(user_id, expense_description, user_ids, total_amount)
    @payer = User.find(user_id).extend RegistrarRole
    @expense = Expense.new(description: expense_description)
    @people = user_ids
    @total_amount = total_amount
  end

  def execute
    execute_in_context do
      payer.record_shared_expense_payment
    end
  end
end
