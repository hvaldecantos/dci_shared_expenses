require './context_accessor'
require './expense'

module DivisionFixerRole
  include ContextAccessor

  def fix_inexact_division
    diff = (self.total_amount - context.total_amount)
    diff > 0 ? add = -0.01 : add = 0.01
    (diff.abs * 100).to_int.times{|i| self.shares[i-1].amount += add; self.shares[i-1].save }
  end

end
