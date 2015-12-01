require 'active_record'
require './db_schema'

class User < ActiveRecord::Base
  has_many :paid_expenses, inverse_of: :payer, foreign_key: :user_id, class_name: :Expense
end
