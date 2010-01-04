class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Comment
    can :read, :all do |object_class|
      object_class != User
    end
    if user
      if user.role?(:author)
        can :create, Post
        can :update, Post do |post|
          post.try(:user) == user
        end
      end
      if user.role?(:moderator)
        can :manage, Post
      end
      if user.role?(:admin)
        can :manage, :all
      end
    end
  end
end
