require 'rails_helper'

RSpec.describe "welcome index page", type: :features do
  context 'as a visitor' do
    it 'can see welcome page' do

      visit '/'

      has_link?("Shelters Index")
      has_link?("Pets Index")
      expect(page).to have_content("Adopt dont Shop!!")
      expect(page).to have_content("Why you should adpot...")
      expect(page).to have_content("Why you shouldn't buy...")
    end
  end
end
