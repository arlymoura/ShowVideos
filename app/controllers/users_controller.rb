# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  # GET /users
  def index
    @users = User.includes(:videos)
                 .paginate(page: params[:page], per_page: 20)
                 .order('created_at DESC')
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: notice_msg('criado') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: notice_msg('atualizado') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: notice_msg('destruido') }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def notice_msg(action)
    "User #{action} com Sucesso!"
  end

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
