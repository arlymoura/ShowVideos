# frozen_string_literal: true

class Video < ApplicationRecord
  belongs_to :user

  validates :titulo, presence: true
  validates :url, presence: true,
                  format: { with: /([^\s]+(\.(m3u8)))/i,
                            message: 'Por favor, digite uma url no formato .m3u8' }

  def update_views
    self.views += 1
    save
  end
end
