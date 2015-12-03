require './context_accessor'
require './split_expense_context'

module PayerRole
  include ContextAccessor

  def record_payment
    SplitExpenseContext::execute(context.expense.id, context.payee_ids, context.total_amount)
    context.payer.payments.create(expense: context.expense)
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
  def print_balance
    debtors = self.compute_debtors
    creditors = self.compute_creditors
    balance = debtors.merge(creditors).inject({}){|h, (k,v)| h.merge( k => {name: v[:name], amount: 0.0} ) }
    balance = balance.merge(debtors).merge(creditors) {|participant, deb, cred| {name: deb[:name], amount: deb[:amount] - cred[:amount]} }
    puts "- Balance statement for #{self.name}"
    balance.each {|k,v| puts "id: %-3d participant: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
  end
end
