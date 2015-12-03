require './context_accessor'

module AccountantRole
  include ContextAccessor

  def compute_creditors
    creditors = {}
    context.received_payments.each do |p|
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
    context.made_payments.each do |p|
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
