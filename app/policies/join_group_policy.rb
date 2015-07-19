class JoinGroupPolicy
  def initialize(group, user)
    @group = group
    @user = user
  end

  def valid?
    domain_restrictions_satisfied?
  end

  private

  attr_reader :group, :user

  def domain_restrictions_satisfied?
    group.domain.nil? || group.domain.empty? ||
      user_domain.downcase == group.domain.downcase
  end

  def user_domain
    user.email.split('@').last
  end
end
