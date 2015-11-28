require './context_accessor'
require './accountant_role'
require './user'

class DisplayBalanceContext
  attr_reader :accountant, :payments_made, :payments_received
  include ContextAccessor

  def self.execute(user_id)
    DisplayBalanceContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @payments_made = @accountant.payments
    @payments_received = Payment.where('user_id != ?', @accountant.id)
  end

  def execute
    execute_in_context do
      debtors = accountant.compute_debtors
      creditors = accountant.compute_creditors
      balance = debtors.merge(creditors).inject({}){|h, (k,v)| h.merge( k => {name: v[:name], amount: 0.0} ) }
      balance = balance.merge(debtors).merge(creditors) {|user, deb, cred| {name: deb[:name], amount: deb[:amount] - cred[:amount]} }
      balance.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
