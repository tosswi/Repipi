class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      case resource
      when Admin
        admins_genres_path
      when User
        recipes_path
      end
    end

    def after_sign_out_path_for(resource)
      case resource
      when :admin
        new_admin_session_path
      when :user
        root_path
      end
    end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:nickname,:sex,:allergies, :phone_number, :image])
  end
  # データ更新時のパラメーターを設定する
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:email,:nickname,:sex,:allergies, :phone_number, :image])
  end
end
