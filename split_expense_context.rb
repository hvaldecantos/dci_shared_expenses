require './context_accessor'
require './registrar_role'
require './user'
require './expense'

class SplitExpenseContext
  attr_reader :expense, :participants, :splited_amount
  include ContextAccessor

  def self.execute(expense_id, user_ids, total_amount)
    SplitExpenseContext.new(expense_id, user_ids, total_amount).execute
  end

  def initialize(expense_id, user_ids, total_amount)
    @expense = Expense.find(expense_id)
    @participants = user_ids.map{ |user_id| User.find(user_id).extend RegistrarRole }
    @splited_amount = (total_amount / participants.size).round(2)
  end

  def execute
    execute_in_context do
      participants.each{ |person| person.split_expense }
    end
  end
end
