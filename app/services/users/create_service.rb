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

        ServiceResult.new(success: true, user: user)
      else
        ServiceResult.new(success: false, errors: user.errors.full_messages)
      end
    end
  end

  class ServiceResult
    attr_reader :user, :errors

    def initialize(success:, user: nil, errors: [])
      @success = success
      @user = user
      @errors = errors
    end

    def success?
      @success
    end
  end
end
