module Users
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      user = User.new(@params)

      if user.save
        ActiveSupport::Notifications.instrument("user.created", user: user)
        WelcomeEmailJob.perform_later(user.id)

        ResultService.success(user: user)
      else
        ResultService.failure(errors: user.errors.full_messages, user: user)
      end
    end
  end
end
