module ControllerMacros
  def sign_in_manager
    group = double
    user = double "User", manager?: true, kind_of?: true, admin?: false,
                          super_user?: true, current_group: group
    allow(request.env['warden']).to receive(:authenticate!).and_return user
    allow(controller).to receive(:current_user).and_return user

    user
  end
end
