class StaticPagesController < ApplicationController
  def home
  	redirect_to overview_path if user_signed_in?
  end

  def help
  end
end
