class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Comment
    can [:read, :archive, :tag], :all
    cannot :read, User
    if user
      if user.role?(:author)
        can :create, Post
        can :update, Post do |p|
          p.try(:user) == user
        end
      end
      if user.role?(:moderator)
        can :update, Post
        can :destroy, [Post, Comment]
        can :read, User
      end
      if user.role?(:admin)
        can :manage, :all
      end
      can :update, User do |u|
        u == user
      end
    end
  end
end
