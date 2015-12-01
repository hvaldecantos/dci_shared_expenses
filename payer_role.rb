require './context_accessor'

module PayerRole
  include ContextAccessor

  def record_made_payment
    context.expense.user_id = self.id
    context.expense.save
  end

  def compute_debtors
    debtors = {}
    context.paid_expenses.each do |p|
      p.shares.each do |s|
        next if s.user == self
        debtors[s.user.id] ||= { name: "", amount: 0.0 }
        debtors[s.user.id][:name] = s.user.name
        debtors[s.user.id][:amount] += s.amount
      end
    end
    debtors
  end
end
