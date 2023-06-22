class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, User, id: user.id
      can :delete, Post, author_id: user.id
      can :delete, Comment, author_id: user.id
    end
  end
end
