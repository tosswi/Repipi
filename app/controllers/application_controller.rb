class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
    def after_sign_in_path_for(resource)
      case resource
      when Admin
        admins_path
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
    #sign_up時にはアレルギー情報を文字列にする必要がある。
    #deviseの処理であるためconfigure_permitted_parameterをオーバーライドし、パラメーターを上書きして実現。
    # if params[:commit] == "Sign up"
    #   params[:user][:allergy] = params[:user][:allergy]&.join("/")
    # end
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:nickname,:sex,:allergy, :phone_number, :image])
  end
  # データ更新時のパラメーターを設定する
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:email,:nickname,:sex,:allergy, :phone_number, :image])
  end
  def set_search
    @search = Recipe.ransack(params[:q]) #ransackメソッド推奨
    @search_recipes = @search.result.page(params[:page]).per(3)
  end
end
