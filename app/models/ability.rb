class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, User, id: user.id
      can %i[read manage], Post, author_id: user.id
      can %i[read manage], Comment, author_id: user.id
    end
  end
end
