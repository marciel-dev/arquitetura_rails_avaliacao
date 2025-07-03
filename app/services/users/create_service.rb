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

        ResultService.new(success: true, user: user)
      else
        ResultService.new(success: false, errors: user.errors.full_messages)
      end
    end
  end
end
