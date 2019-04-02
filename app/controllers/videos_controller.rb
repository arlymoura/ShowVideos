# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]

  # GET /videos
  def index
    @videos = Video.where(user_id: current_user.id)
                   .paginate(page: params[:page], per_page: 20)
                   .order('created_at DESC')
  end

  # GET /videos/1
  def show; end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit; end

  # POST /videos
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: notice_msg('criado') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /videos/1
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: notice_msg('atualizado') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: notice_msg('destruido') }
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def notice_msg(action)
    "Video #{action} com Sucesso!"
  end

  def video_params
    params.require(:video).permit(:titulo, :url, :views)
          .merge(user_id: current_user.id)
  end
end
