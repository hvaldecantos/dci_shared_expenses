require './context_accessor'
require './expense'

module RegistrarRole
  include ContextAccessor

  def split_expense
    splited_amount = context.total_amount / context.people.size
    self.shares.create(expense: context.expense, amount: splited_amount)
  end
end
