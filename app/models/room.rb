class Room < ActiveRecord::Base

  # user_id: must be present
  validates :user_id, :presence => true

  # name: must be present; must be unique in combination with user_id
  validates :name, :presence => true, :uniqueness => { :scope => :user_id }

  belongs_to :user
  has_many :lightbulbs

end
