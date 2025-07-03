class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.active.order(:created_at).page(params[:page])
  end

  def show
    @user = @user.decorate
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    result = Users::UpdateService.new(@user, user_params).call

    if result.success?
      redirect_to admin_user_path(@user), notice: "Usuário atualizado com sucesso."
    else
      flash.now[:alert] = result.errors.join(', ')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.soft_delete!
    redirect_to admin_users_path, notice: "Usuário desativado."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :status)
  end
end
