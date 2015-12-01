require './context_accessor'

module PayerRole
  include ContextAccessor

  def record_made_payment
    context.expense.user_id = self.id
    context.expense.save
  end
end
