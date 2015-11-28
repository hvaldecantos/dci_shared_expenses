require './context_accessor'
require './expense'

module RegistrarRole
  include ContextAccessor

  def record_share
    self.shares.create(expense: context.expense, amount: context.share)
  end
end
