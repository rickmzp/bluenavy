class SessionsController < ApplicationController
  skip_before_filter :ensure_sign_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    sign_in_as params[:user][:name]
    redirect_to root_url
  end

  def destroy
    sign_out
  end
end
