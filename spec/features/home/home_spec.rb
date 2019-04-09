require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  it 'have a title' do
    visit root_path

    text = 'Workshop de Ensino em Pensamento Computacional, Algoritmos e Programação'
    expect(page).to have_text(text)
  end
end
