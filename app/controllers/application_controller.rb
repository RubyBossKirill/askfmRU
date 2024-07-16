class ApplicationController < ActionController::Base
  helper_method :current_user, :random_color

  private
  def random_color
    [
      ['Красный', 'rgba(255, 87, 51, 0.2)'],
      ['Зелёный', 'rgba(51, 255, 87, 0.2)'],
      ['Голубой', 'rgba(51, 87, 255, 0.2)'],
      ['Розовый', 'rgba(255, 51, 161, 0.2)'],
      ['Оранжевый', 'rgba(255, 191, 51, 0.2)']
    ].sort_by{ rand }
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
