require './context_accessor'
require './expense'

module AccountantRole
  include ContextAccessor

  def compute_debtors
    debtors = {}
    context.payments_made.each do |p|
      p.expense.shares.each do |s|
        next if s.user_id == context.accountant.id
        debtors[s.user.id] ||= { name: "", amount: 0.0 }
        debtors[s.user.id][:name] = s.user.name
        debtors[s.user.id][:amount] += s.amount
      end
    end
    debtors
  end

  def compute_creditors
    creditors = {}
    context.payments_received.each do |p|
      p.expense.shares.each do |s|
        next if s.user_id != context.accountant.id
        creditors[p.user.id] ||= { name: "", amount: 0.0 }
        creditors[p.user.id][:name] = p.user.name
        creditors[p.user.id][:amount] += s.amount
      end
    end
    creditors
  end
end
