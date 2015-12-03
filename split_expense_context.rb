require './context_accessor'
require './payee_role'
require './user'
require './expense'

class SplitExpenseContext
  attr_reader :expense, :payees, :split_amount
  include ContextAccessor

  def self.execute(expense_id, user_ids, total_amount)
    SplitExpenseContext.new(expense_id, user_ids, total_amount).execute
  end

  def initialize(expense_id, user_ids, total_amount)
    @expense = Expense.find(expense_id)
    @payees = user_ids.map{ |user_id| User.find(user_id).extend PayeeRole }
    @split_amount = (total_amount / payees.size).round(2)
  end

  def execute
    execute_in_context do
      payees.each{ |payee| payee.record_share }
    end
  end
end
