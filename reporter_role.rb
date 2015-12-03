require './context_accessor'
require './split_expense_context'

module ReporterRole
  include ContextAccessor

  def print_balance
    debtors = self.compute_debtors
    creditors = self.compute_creditors
    balance = debtors.merge(creditors).inject({}){|h, (k,v)| h.merge( k => {name: v[:name], amount: 0.0} ) }
    balance = balance.merge(debtors).merge(creditors) {|participant, deb, cred| {name: deb[:name], amount: deb[:amount] - cred[:amount]} }
    print balance, "- Balance statement for #{self.name}:"
  end
  def print somthing, message
    puts message
    somthing.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
  end
end
