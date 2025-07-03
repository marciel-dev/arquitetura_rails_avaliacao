class ResultService
  attr_reader :success, :errors, :data

  def initialize(success:, errors: [], data: {})
    @success = success
    @errors = errors
    @data = data
  end

  def success?
    success
  end

  def self.success(**data)
    new(success: true, data: data)
  end

  def self.failure(errors: [])
    new(success: false, errors: Array(errors))
  end
end
