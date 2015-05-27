class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :create, Signature
    can :create, Contribution

    if user && user.admin?
      can :close_for_contribution, Project
      can :reopen_for_contribution, Project
      can :manage, Adoption
      can :manage, Project
      can :claim, GoogleAuthorization
      can :grant, GoogleAuthorization
    end
  end
end
