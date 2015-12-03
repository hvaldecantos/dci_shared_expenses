require './context_accessor'

module RegistrarRole
  include ContextAccessor

  def split_expense
    self.shares.create(expense: context.expense, amount: context.splited_amount)
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
