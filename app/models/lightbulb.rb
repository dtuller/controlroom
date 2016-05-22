class Lightbulb < ActiveRecord::Base

  # user_id: must be present
  validates :user_id, :presence => true

  # control_id: must be present; must be unique in combination with user_id
  validates :control_id, :presence => true, :uniqueness => { :scope => :user_id }

  # name: must be present
  validates :name, :presence => true

  # state_id: no rules

  # room_id: no rules

  belongs_to :user
  belongs_to :room
  belongs_to :state

end
