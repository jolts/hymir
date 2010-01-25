class Ability
  include CanCan::Ability

  def initialize(user)
    # Guests can create comments and see everything except users
    can :create, Comment
    can [:read, :archive, :tag], :all

    cannot :read, User

    # Someone logged in
    if user
      # Authors can create posts and edit their own posts
      if user.role?(:author)
        can :create, Post
        can :update, Post do |p|
          p.try(:user) == user
        end
      end

      # Moderators can destroy comments
      if user.role?(:moderator)
        can :destroy, Comment
      end

      # Admins can manage everything
      if user.role?(:admin)
        can :manage, :all
      end

      # Put this last so that even admins can only edit their own password
      can :update, User do |u|
        u == user
      end
    end
  end
end
