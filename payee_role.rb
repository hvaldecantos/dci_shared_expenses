require './context_accessor'

module PayeeRole
  include ContextAccessor

  def record_received_payment
    self.shares.create(expense: context.expense, amount: context.partial_amount)
  end

  def compute_creditors
    creditors = {}
    context.received_payments.each do |p|
      p.shares.each do |s|
        next if s.user != self
        creditors[p.payer.id] ||= { name: "", amount: 0.0 }
        creditors[p.payer.id][:name] = p.payer.name
        creditors[p.payer.id][:amount] += s.amount
      end
    end
    creditors
  end
end
