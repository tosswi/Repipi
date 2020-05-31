# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  before_action :reject_user, only: [:create]

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      # パスワードが正しいかつactive_for_authentication?メソッドでの処理でfalseである場合
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        flash[:errors] = "退会済みです。"
        redirect_to new_user_session_path
      end
    else
      flash[:errors] = "必須項目を入力してください。"
    end
  end
end
