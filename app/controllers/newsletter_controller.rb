class NewsLetterController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_email_validation if user
    redirect_to root_url, :notice => "A confirmation email was sent"
  end
end
