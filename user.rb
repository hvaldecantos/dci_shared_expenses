require 'active_record'
require './db_schema'

class User < ActiveRecord::Base
  has_many :shares, inverse_of: :user
  has_many :payments, inverse_of: :user
  has_many :provided_settlements, :foreign_key => :user_id, :class_name => 'Settlement', inverse_of: :user
  has_many :received_settlements, :foreign_key => :creditor_id, :class_name => 'Settlement', inverse_of: :creditor
end
