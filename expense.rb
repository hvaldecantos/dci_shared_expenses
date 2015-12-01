require 'active_record'
require './db_schema'

class Expense < ActiveRecord::Base
  belongs_to :payer, inverse_of: :paid_expenses, class_name: :User, foreign_key: :user_id
  has_many :shares, inverse_of: :expense
  has_many :users, :through => :shares
end
