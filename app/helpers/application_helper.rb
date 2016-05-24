module ApplicationHelper

  def get_scenes
    if current_user.present?
      @scenes = Scene.where("user_id = ?", current_user.id).all
    end
  end

end
