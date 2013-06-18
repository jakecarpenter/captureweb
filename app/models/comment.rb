class Comment < ActiveRecord::Base
  belongs_to :card
  attr_accessible :content, :contributor
end
