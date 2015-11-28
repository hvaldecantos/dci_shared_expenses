require './context_accessor'
require './expense'
require './split_expense_equally_context'
require './payment'

module RegistrarRole
  include ContextAccessor

  def record_share
    self.shares.create(expense: context.expense, amount: context.share)
  end
  def record_shared_expense_payment
    context.expense.save
    SplitExpenseEquallyContext::execute context.expense.id, context.people, context.total_amount
    Payment.new(user_id: self.id, expense_id: context.expense.id).save
  end
  def show_report
    puts "Payments related to #{self.name} -----------"
    context.all_payments.each do |p|
      p.expense.shares.each do |s|
        next if (self != p.user and self != s.user) or (p.user == s.user)
        puts "payer: %-8s receiver: %-8s %-10s $%5.2f" % [p.user.name, s.user.name, p.expense.description, s.amount]
      end
    end
  end
end
