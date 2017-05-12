# https://gist.github.com/jwo/1255275 taken from

class AuthController < ActionController::Base
  # prepend_before_filter :require_no_authentication, :only => [:create ]
  # include Devise::Controllers::InternalHelpers
  # snipped taken from

  before_filter :ensure_params_exist


  respond_to :json
  def create
    params.require(:user).permit(:email, :password, :password_confirmation)
    user = User.new(params[:user])
    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end


  def create_session
    build_resource
    resource = User.find_for_database_authentication(:login=>params[:user_login][:login])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in("user", resource)
      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :login=>resource.login, :email=>resource.email}
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:user].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end


end
