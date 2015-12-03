require './context_accessor'

module RegistrarRole
  include ContextAccessor

  def split_expense
    self.shares.create(expense: context.expense, amount: context.splited_amount)
  end
end
