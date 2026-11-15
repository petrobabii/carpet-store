class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern

  private

  def require_admin
    unless Current.user&.admin?
      redirect_to root_path, alert: "У вас немає прав доступу до цієї сторінки."
    end
  end
end