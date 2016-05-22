class State < ActiveRecord::Base

  # user_id: must be present
  validates :user_id, :presence => true

  # name: must be present; must be unique in combination with user_id
  validates :name, :presence => true, :uniqueness => { :scope => :user_id }

  # effect: must be present
  validates :effect, :presence => true

  # alert: must be present
  validates :alert, :presence => true

  # blue: must be present
  validates :blue, :presence => true

  # green: must be present
  validates :green, :presence => true

  # red: must be present
  validates :red, :presence => true

  # brightness: must be present
  validates :brightness, :presence => true

  # on: must be present
  validates :on, :presence => true

  belongs_to :user

end
