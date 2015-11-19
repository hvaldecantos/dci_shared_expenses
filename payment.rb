require 'active_record'
require './db_schema'

class Payment < ActiveRecord::Base
  belongs_to :user, inverse_of: :payments, required: true
  belongs_to :expense, inverse_of: :payment, required: true
end
