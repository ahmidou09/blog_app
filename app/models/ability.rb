class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :destroy, Post, author_id: user.id
    can :destroy, Comment, user_id: user.id
    can :create, Post
    can :read, Post

    return unless user.admin?

    can :destroy, Post
    can :destroy, Comment
  end
end
