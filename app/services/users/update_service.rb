module Users
  class UpdateService
    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      if @user.update(filtered_params)
        ResultService.success(user: @user)
      else
        ResultService.failure(errors: @user.errors.full_messages, user: @user)
      end
    end

    private

    def filtered_params
      if @params[:password].blank?
        @params.except(:password)
      else
        @params
      end
    end
  end
end