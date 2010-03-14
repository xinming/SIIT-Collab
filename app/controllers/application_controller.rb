# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :require_admin

  before_filter :build_menu
  before_filter :set_footer

  private
    def build_menu  #Build Menu items
      @menus = []
      if current_user
        @menus << {:name => "Dashboard", :url => root_path}
        @menus << {:name => "Share", :url => shares_path}
        @menus << {:name => "Groups", :url => groups_path}
        @menus << {:sep => true }
        @menus << {:name => "Logout", :url => user_session_path, :options => { :method => :delete }}
      else
        @menus << {:name => "Home", :url => root_path}
        @menus << {:sep => true }
        @menus << {:name => "Login", :url => new_user_session_path}
        @menus << {:sep => true }
        @menus << {:name => "Don't have an account?", :url => "#"}
      end
    end

    def set_footer
      @footer = render_to_string :partial => "shared/footer"
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page."
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page."
        redirect_to root_url
        return false
      end
    end

    def require_admin
      if current_user && current_user.login == "mpbod"
        return true
      else
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end

