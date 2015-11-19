require './context_accessor'
require './expense'

module RegistrarRole
  include ContextAccessor

  def create_expense
    Expense.new(description: context.description, amount: context.amount).save
  end
end
