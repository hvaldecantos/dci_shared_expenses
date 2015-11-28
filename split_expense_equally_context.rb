require './context_accessor'
require './registrar_role'
require './division_fixer_role'
require './user'
require './expense'

class SplitExpenseEquallyContext
  attr_reader :expense, :registrars, :share, :total_amount
  include ContextAccessor

  def self.execute(expense_id, user_ids, total_amount)
    SplitExpenseEquallyContext.new(expense_id, user_ids, total_amount).execute
  end

  def initialize(expense_id, user_ids, total_amount)
    @expense = Expense.find(expense_id).extend DivisionFixerRole
    @registrars = user_ids.map{ |user_id| User.find(user_id).extend RegistrarRole }
    @share = (total_amount / user_ids.size).round(2)
    @total_amount = total_amount
  end

  def execute
    execute_in_context do
      registrars.each{ |registrar| registrar.record_share }
      expense.fix_inexact_division
    end
  end
end
