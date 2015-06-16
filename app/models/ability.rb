class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Project
    can :create, Signature
    can :create, Contribution

    if user.present?
      can :create, Project
      can :manage, Project, user_id: user.id
      can :manage, GoogleAuthorization

      if user.admin?
        can :close_for_contribution, Project
        can :reopen_for_contribution, Project
        can :manage, Adoption
        can :manage, Project
      end
    end
  end
end
