require './context_accessor'

module AccountantRole
  include ContextAccessor

  def compute_creditors
    creditors = {}
    context.payments.each do |p|
      p.expense.shares.each do |s|
        next if s.user != self
        creditors[p.user.id] ||= { name: "", amount: 0.0 }
        creditors[p.user.id][:name] = p.user.name
        creditors[p.user.id][:amount] += s.amount
      end
    end
    creditors
  end

  def compute_debtors
    debtors = {}
    context.payments.each do |p|
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
