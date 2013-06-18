class Card < ActiveRecord::Base
  belongs_to :capture
  belongs_to :user
  has_many :comments
  attr_accessible :content, :contributor, :name, :serviceId, :serviceTime, :title, :visibility
end