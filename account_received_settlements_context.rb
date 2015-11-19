require './context_accessor'
require './accountant_role'
require './user'
require './settlement'

class AccountReceivedSettlementsContext
  attr_reader :accountant, :settlements
  include ContextAccessor

  def self.execute(user_id)
    AccountReceivedSettlementsContext.new(user_id).execute
  end

  def initialize(user_id)
    @accountant = User.find(user_id).extend AccountantRole
    @settlements = @accountant.received_settlements
  end

  def execute
    execute_in_context do
      creditors = accountant.compute_received_settlements
      creditors.each {|k,v| puts "user: #{k} amount: #{v}"}
    end
  end
end
