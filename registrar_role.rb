require './context_accessor'
require './expense'

module RegistrarRole
  include ContextAccessor

  def create_expense
    Expense.new(description: context.description).save
  end

  def split_expense
    context.shares.each do |user_id, amount|
      Share.new(expense_id: context.expense.id, user_id: user_id, amount: amount).save
    end
  end
end
