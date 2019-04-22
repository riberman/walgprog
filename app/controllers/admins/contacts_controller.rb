class Admins::ContactsController < Admins::BaseController
  before_action :authenticate_admin!

  def index
    @contacts = Contact.all
  end

  def show

  end

  def edit

  end
end
