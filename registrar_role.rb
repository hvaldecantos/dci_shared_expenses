require './context_accessor'

module RegistrarRole
  include ContextAccessor

  def split_expense
    self.shares.create(expense: context.expense, amount: context.splited_amount)
  end
  def record_payment
    SplitExpenseContext::execute(context.expense.id, context.participants, context.total_amount)
    # the registrar is the payer - Is it better to have a payer role?
    context.registrar.payments.create(expense: context.expense)
  end
end
