require './context_accessor'
require './expense'

module AccountantRole
  include ContextAccessor

  def compute_debtors
    debtors = {}
    context.payments.each do |p|
      Share.order('user_id').where('expense_id = ? and user_id != ?', p.expense_id, context.accountant.id).each do |s|
        debtors[s.user.name] == nil ? debtors[s.user.name] = s.amount : debtors[s.user.name] += s.amount
      end
    end
    debtors
  end
end
