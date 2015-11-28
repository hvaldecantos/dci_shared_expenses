require 'active_record'
require './db_schema'

class Expense < ActiveRecord::Base
  has_many :shares, inverse_of: :expense
  has_one :payment, inverse_of: :expense

  def total_amount
    shares.inject(0){|r, s| r + s.amount}
  end
end
