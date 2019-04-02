# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :show, to: :read
    alias_action :index, :show, :new, :edit, :update, :destroy, to: :crud

    user ||= User.new
    if user.admin?
      can :manage, :all
      can :manage, User
    else
      can :default, Video
      can :crud, Video do |item|
        item.user.id == user.id
      end
    end
  end
end
