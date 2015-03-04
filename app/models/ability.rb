class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :create, Signature
    can :create, Contribution

    if user && user.admin?
      can :close_for_contribution, Project
      can :reopen_for_contribution, Project
      can :create, Adoption
      can :manage, Project
    end
  end
end
