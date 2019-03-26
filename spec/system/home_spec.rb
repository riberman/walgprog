require 'rails_helper'

RSpec.describe 'Home', type: :system do
  it 'sees the page title' do
    visit root_path

    title = 'Workshop de Ensino em Pensamento Computacional, Algoritmos e Programação'
    expect(page).to have_text(title)
  end
end
