require './context_accessor'
require './accountant_role'
require './user'
require './payment'

class PrintCreditorsContext
  attr_reader :accountant, :payments
  include ContextAccessor

  def self.execute(user_id)
    PrintCreditorsContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @payments = Payment.where('user_id != ?', @accountant.id)
  end

  def execute
    execute_in_context do
      creditors = accountant.compute_creditors
      puts "- #{accountant.name} creditors:"
      creditors.each {|k,v| puts "id: %-3d user: %-8s amount: %5.2f" % [k, v[:name], v[:amount]] }
    end
  end
end
