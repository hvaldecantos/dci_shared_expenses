require './context_accessor'
require './user'
require './expense'
require './payer_role'
require './payee_role'

class SplitExpenseContext
  attr_reader :reporter, :participants, :expense, :partial_amount
  include ContextAccessor

  def self.execute(user_id, user_ids, expense_description, total_amount)
    SplitExpenseContext.new(user_id, user_ids, expense_description, total_amount).execute
  end

  def initialize(user_id, user_ids, expense_description, total_amount)
    @reporter = User.find(user_id).extend ReporterRole
    @participants = user_ids.map{|user_id| User.find(user_id).extend PayeeRole}
    @expense = Expense.create(description: expense_description)
    @partial_amount = (total_amount / participants.size).round(2)
  end

  def execute
    execute_in_context do
      reporter.split_expense
    end
  end
end
