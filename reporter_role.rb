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
  def show_report
    puts "- Payments related to #{self.name}"
    context.all_expenses.each do |e|
      e.shares.each do |s|
        next if (self != e.payment.user and self != s.user) or (e.payment.user == s.user)
        puts "payer: %-8s receiver: %-8s %-10s $%5.2f" % [e.payment.user.name, s.user.name, e.description, s.amount]
      end
    end
  end
end
