module SessionsHelper
  # Sign in a user and set the browser's remember_token cookie
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  # Sign out the current user and delete the browser's remember_token cookie
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # Returns true if signed in
  def signed_in?
    !current_user.nil?
  end

  # Sets the current user
  def current_user=(user)
    @current_user = user
  end

  # Returns the current user
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # Checks that a user is the same logged in user
  def current_user?(user)
    user == current_user
  end

  # Redirects the user back to their stored location, or a default location
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # Stores the user's current location
  def store_location
    session[:return_to] = request.url if request.get?
  end

  # -- Shared Before Filters --
  # Redirects a to the sign in page when no User is signed in
  def signed_in_user
    unless signed_in?
      store_location
      flash[:warning] = 'Please sign in.'
      redirect_to signin_url
    end
  end

  # Redirects to the application root url if the User is not an admin
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
