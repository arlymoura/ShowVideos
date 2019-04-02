# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @videos = Video.paginate(page: params[:page], per_page: 6)
                   .order('created_at DESC')
  end
end
