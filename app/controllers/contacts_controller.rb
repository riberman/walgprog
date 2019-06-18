class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
    action_success? @contact.save, :new, 'flash.actions.create.m'
  end
end