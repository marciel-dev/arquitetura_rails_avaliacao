require "test_helper"

class WelcomeEmailJobTest < ActiveJob::TestCase
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.welcome_email(user).deliver_now
  end
end
