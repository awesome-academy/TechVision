class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale
  before_action :topic_name

  def topic_name
     @topics_name = Topic.all.limit(Settings.number_topic)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def hello
    render html: "Hello TechVision"
  end

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t("index.Please log in")
      redirect_to login_url
    end
  end
end
