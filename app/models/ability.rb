class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Comment
    can [:read, :archive, :tag], :all
    cannot :read, User
    if user
      if user.role?(:author)
        can :create, Post
        can :update, Post do |post|
          post.try(:user) == user
        end
      end
      if user.role?(:moderator)
        can :manage, Post
        can :destroy, Comment
      end
      if user.role?(:admin)
        can :manage, :all
      end
    end
  end
end
