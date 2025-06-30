class UsersController < ApplicationController
  def index
    @users = User.active.recent.decorate
  end

  def new
    @user = User.new
  end

  def create
    result = Users::CreateService.new(user_params).call

    if result.success?
      redirect_to users_path, notice: 'Usuário criado com sucesso.'
    else
      @user = User.new(user_params)
      flash.now[:alert] = result.errors.join(', ')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
