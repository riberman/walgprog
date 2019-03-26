require "rails_helper"

RSpec.describe "Home", type: :system do

  it "should see the page title" do
    visit root_path

    expect(page).to have_text("Workshop de Ensino em Pensamento Computacional, Algoritmos e Programação")
  end
end
