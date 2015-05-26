class GoogleAuthorization < ActiveRecord::Base
  belongs_to :user

  # TODO: adicionar validações
end
