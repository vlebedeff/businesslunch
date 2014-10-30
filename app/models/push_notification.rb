class PushNotification
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def self.lunch_ready(user)
    new(user).lunch_ready
  end

  def lunch_ready
    push = Parse::Push.new data, ""
    push.where = query.where
    push.save
  end

  private
  def installations
    user.parse_installations.pluck(:parse_object_id)
  end

  def query
    @query ||= Parse::Query.new(nil).value_in("objectId", installations)
  end

  def data
    @data ||= {
      alert: 'Neam-neam is here',
      sound: 'Default'
    }
  end
end
