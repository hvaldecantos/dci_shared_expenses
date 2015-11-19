require './context_accessor'
require './registrar_role'
require './user'
require './expense'

class SplitExpenseContext
  attr_reader :registrar, :expense, :shares
  include ContextAccessor

  def self.execute(user_id, expense_id, shares)
    SplitExpenseContext.new(user_id, expense_id, shares).execute
  end

  def initialize(user_id, expense_id, shares)
    @registrar = User.find(user_id).extend RegistrarRole
    @expense = Expense.find(expense_id)
    @shares = shares
  end

  def execute
    execute_in_context do
      @registrar.split_expense
    end
  end
end
