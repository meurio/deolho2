class User < ActiveRecord::Base
  acts_as_our_cities_user

  def signed? project
    Signature.where(user_id: self.id, project_id: project.id).any?
  end
end
