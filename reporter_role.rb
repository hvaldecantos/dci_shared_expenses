require './context_accessor'

module ReporterRole
  include ContextAccessor

  def show_report
    puts "- Payments related to #{self.name}"
    context.all_expenses.each do |e|
      e.shares.each do |s|
        next if (self != e.payer and self != s.user) or (e.payer == s.user) or (e.payer == nil)
        puts "payer: %-8s receiver: %-8s %-10s $%5.2f" % [e.payer.name, s.user.name, e.description, s.amount]
      end
    end
  end

  def split_expense
    context.participants.each do |participant|
      # participant.record_received_payment
      participant.shares.create(expense: context.expense, amount: context.partial_amount)
    end
  end
end
