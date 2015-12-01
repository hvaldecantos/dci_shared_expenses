require 'active_record'
require './db_schema'

class Expense < ActiveRecord::Base
  belongs_to :payer, inverse_of: :paid_expenses, class_name: :User, required: true
end
