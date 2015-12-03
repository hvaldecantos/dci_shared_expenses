require './context_accessor'

module PayeeRole
  include ContextAccessor

  def record_share
    self.shares.create(expense: context.expense, amount: context.split_amount)
  end
end
