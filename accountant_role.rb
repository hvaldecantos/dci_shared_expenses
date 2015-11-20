require './context_accessor'
require './expense'

module AccountantRole
  include ContextAccessor

  def compute_debtors
    debtors = {}
    context.made_payments.each do |p|
      Share.order('user_id').where('expense_id = ? and user_id != ?', p.expense_id, context.accountant.id).each do |s|
        debtors[s.user.name] == nil ? debtors[s.user.name] = s.amount : debtors[s.user.name] += s.amount
      end
    end
    debtors
  end

  def compute_creditors
    creditors = {}
    context.received_payments.each do |p|
      Share.where('expense_id = ? and user_id == ?', p.expense_id, context.accountant.id).each do |s|
        creditors[p.user.name] == nil ? creditors[p.user.name] = s.amount : creditors[p.user.name] += s.amount
      end
    end
    creditors
  end

  def compute_received_settlements
    creditors = {}
    context.settlements.each do |s|
      creditors[s.user.name] == nil ? creditors[s.user.name] = s.amount : creditors[s.user.name] += s.amount
    end
    creditors
  end
  def compute_provided_settlements
    creditors = {}
    context.settlements.each do |s|
      creditors[s.creditor.name] == nil ? creditors[s.creditor.name] = s.amount : creditors[s.creditor.name] += s.amount
    end
    creditors
  end
end
