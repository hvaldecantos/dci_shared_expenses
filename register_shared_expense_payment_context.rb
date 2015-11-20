require './context_accessor'
require './split_expense_context'
require './expense'
require './user'

class RegisterSharedExpensePaymentContext
  attr_reader :payer, :expense, :shares
  include ContextAccessor

  def self.execute(user_id, expense_description, shares)
    RegisterSharedExpensePaymentContext.new(user_id, expense_description, shares).execute
  end

  def initialize(user_id, expense_description, shares)
    @payer = User.find(user_id) #.extend PayerRole
    @shares = shares
    @expense = Expense.new(description: expense_description)
  end

  def execute
    execute_in_context do
      expense.save
      SplitExpenseContext::execute payer.id, expense.id, shares
      Payment.new(user_id: payer.id, expense_id: expense.id).save
    end
  end
end
