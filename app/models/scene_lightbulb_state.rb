class SceneLightbulbState < ActiveRecord::Base

  # scene_id: must be present
  validates :scene_id, :presence => true

  # state_id: must be present
  validates :state_id, :presence => true

  # lightbulb: must be present; must be unique in combination with scene_id and state_id
  validates :lightbulb_id, :presence => true, :uniqueness => { :scope => [:scene_id, :state_id] }

  belongs_to :scene
  belongs_to :state
  belongs_to :lightbulb

end
