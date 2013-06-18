class Capture < ActiveRecord::Base
  has_many :cards
  attr_accessible :creator, :description, :endTime, :name, :startTime, :visibility
end
