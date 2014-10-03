module ControllerMacros
  def sign_in_manager
    group = double
    user = double "User", manager?: true, kind_of?: true, admin?: false,
                          super_user?: true, current_group: group
    allow(request.env['warden']).to receive(:authenticate!).and_return user
    allow(controller).to receive(:current_user).and_return user

    user
  end

  def sign_in_api_user
    user = double "User", id: 1
    access_token = double 'AccessToken', resource_owner_id: user.id,
      token: '123', acceptable?: true
    allow(User).to receive(:find).and_return user
    allow(controller).to receive(:doorkeeper_token).and_return access_token

    access_token
  end
end
