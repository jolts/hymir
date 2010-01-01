class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role?(:admin)
        can :manage, :all
      end
      if user.role?(:author)
        can :create, Post
        can :update, Post do |post|
          post.try(:user) == user
        end
      end
      if user.role?(:moderator)
        can :update, Post
        can :destroy, Post
      end
    else
      can :read, :all
    end
  end
end
