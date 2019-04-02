# frozen_string_literal: true

class User < ApplicationRecord
  include ActionView::Helpers
  before_create :set_role
  has_many :videos, dependent: :destroy
  has_enumeration_for :role, with: UserRole, create_helpers: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_role
    self.role ||= UserRole::DEFAULT
  end
end
