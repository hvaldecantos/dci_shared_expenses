require './context_accessor'
require './registrar_role'
require './user'

class CreateExpenseContext
  attr_reader :registrar, :description
  include ContextAccessor

  def self.execute(user_id, description)
    CreateExpenseContext.new(user_id, description).execute
  end

  def initialize(user_id, description)
    @registrar = User.find(user_id).extend RegistrarRole
    @description = description
  end

  def execute
    execute_in_context do
      registrar.create_expense
    end
  end
end
