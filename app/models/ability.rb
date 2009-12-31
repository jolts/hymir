class Ability
  include CanCan::Ability

  # TODO: Add moderator roles
  def initialize(user)
    if user && user.role?(:admin)
      can :manage, :all
    else
      can :read, :all
      if user
        can :create, Comment
        can :update, Comment do |comment|
          comment.try(:user) == user
        end
        if user.role?(:author)
          can :create, Post
          can :update, Post do |post|
            post.try(:user) == user
          end
        end
      end
    end
  end
end
