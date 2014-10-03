module JsonMacros
  def json
    @json ||= JSON.parse(response.body)
  end
end
