require './context_accessor'
require './split_expense_context'

module PayerRole
  include ContextAccessor

  def record_payment
    SplitExpenseContext::execute(context.expense.id, context.payee_ids, context.total_amount)
    self.payments.create(expense: context.expense)
  end
  def compute_debtors
    debtors = {}
    context.paid_expenses.each do |p|
      p.expense.shares.each do |s|
        next if s.user == self
        debtors[s.user.id] ||= { name: "", amount: 0.0 }
        debtors[s.user.id][:name] = s.user.name
        debtors[s.user.id][:amount] += s.amount
      end
    end
    debtors
  end
end
