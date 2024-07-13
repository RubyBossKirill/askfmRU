class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Вы успешно вошли"
    else
      redirect_to log_in_path, notice: "Неверный логин или пароль"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Вы успешно вышли с аккаунта"
  end
end
