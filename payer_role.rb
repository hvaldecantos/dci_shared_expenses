require './context_accessor'
require './split_expense_context'

module PayerRole
  include ContextAccessor

  def record_payment
    SplitExpenseContext::execute(context.expense.id, context.participants, context.total_amount)
    context.payer.payments.create(expense: context.expense)
  end
end
