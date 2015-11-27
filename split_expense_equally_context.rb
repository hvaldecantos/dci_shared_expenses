require './context_accessor'
require './registrar_role'
require './user'
require './expense'

class SplitExpenseEquallyContext
  attr_reader :expense, :people, :total_amount
  include ContextAccessor

  def self.execute(expense_id, user_ids, total_amount)
    SplitExpenseEquallyContext.new(expense_id, user_ids, total_amount).execute
  end

  def initialize(expense_id, user_ids, total_amount)
    @expense = Expense.find(expense_id)
    @people = user_ids.map{ |user_id| User.find(user_id).extend RegistrarRole }
    @total_amount = total_amount
  end

  def execute
    execute_in_context do
      people.each{ |person| person.split_expense }
    end
  end
end
