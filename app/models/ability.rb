class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :create, Signature

    if user && user.admin?
      can :close_for_contribution, Project
      can :reopen_for_contribution, Project
      can :manage, Project
    end
  end
end
