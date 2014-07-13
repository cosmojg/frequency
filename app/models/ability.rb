class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # Note: :manage maps to everything, even to things outside of the normal
    # rails 7 restful methods

    # Base abilities (everyone can do this)
    can :read, User
    cannot :index, User
    can :read, Board
    can :read, Conversation
    can :read, Post
    can :read, Picture
    can :read, Comment
    can :read, Blog

    if !user
      can :create, User
      can :create, UserSession
    else
      can :update, User, id: user.id

      # NOTE: Do we have to restrict by id? It seems user sessions don't care what
      # id you give it
      can :destroy, UserSession

      can :create, Conversation
      can :manage, Conversation, user_id: user.id

      can :mark_all_as_read, Board

      can :create, Post
      can :manage, Post, user_id: user.id
      can [:like, :unlike], Post
      cannot [:like, :unlike], Post, user_id: user.id  # cannot like your own picture

      can :create, Picture
      can :manage, Picture, user_id: user.id
      can [:like, :unlike], Picture
      cannot [:like, :unlike], Picture, user_id: user.id  # cannot like your own picture

      can [:like, :unlike], Blog

      can :create, Comment
      can :manage, Comment, user_id: user.id
      can [:like, :unlike], Comment
      cannot [:like, :unlike], Comment, user_id: user.id  # cannot like your own picture

      if user.moderator? or user.admin?
        can :index, User
        can :manage, Conversation
        can :manage, Post
        can :manage, Picture
        can :manage, Comment
        can :create, Blog
        can :manage, Blog
      end

      if user.admin?
        can [:edit, :update], User  # Don't give admins permission to delete users in the meantime
        can :manage, Board
      end
    end

  end

end
