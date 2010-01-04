class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role?(:author)
        can :create, Comment
        can :create, Post
        can :update, Post do |post|
          post.try(:user) == user
        end
      end
      if user.role?(:moderator)
        can :create, Comment
        can :update, Post
        can :destroy, Post
      end
      if user.role?(:admin)
        can :manage, :all
      end
    else
      can :create, Comment
      can :read, :all
    end
  end
end
