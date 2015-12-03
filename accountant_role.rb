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
end
