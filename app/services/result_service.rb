class ResultService
  attr_reader :result

  def initialize(success, result)
    @success = success
    @result = result
  end

  def success?
    @success
  end
end
