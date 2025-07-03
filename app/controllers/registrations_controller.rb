class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = Users::CreateService.new(user_params.merge(role: :client)).call

    if result.success?
      session[:user_id] = result.data[:user].id
      redirect_to root_path, notice: "Conta criada com sucesso!"
    else
      @user = result.data[:user] 
      flash.now[:alert] = result.errors.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
