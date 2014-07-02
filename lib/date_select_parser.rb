class DateSelectParser
  def initialize(prefix, params)
    @prefix = prefix
    @raw = [
      params["#{prefix}(1i)"],
      params["#{prefix}(2i)"],
      params["#{prefix}(3i)"]
    ].compact.join('-')
  end

  def to_date
    Date.parse(@raw) rescue Date.today
  end
end
