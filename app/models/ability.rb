class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project

    if user && user.admin?
      can :close_for_contribution, Project
    end
  end
end
