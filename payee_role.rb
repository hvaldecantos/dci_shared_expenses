require './context_accessor'

module PayeeRole
  include ContextAccessor

  def record_received_payment
    self.shares.create(expense: context.expense, amount: context.partial_amount)
  end
end
