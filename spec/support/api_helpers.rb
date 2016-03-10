module ApiHelpers
  def json
    JSON.parse(last_response.body)
  end
end