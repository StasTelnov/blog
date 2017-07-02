class ResultService
  def initialize(success, data, status=nil)
    @success = success
    @data = data
    @status = status
  end

  def result
    {json: @data, status: status}
  end

  private

  def status
    @status || default_status
  end

  def default_status
    @success ? 201 : 422
  end
end
