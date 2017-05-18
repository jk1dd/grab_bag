require 'rails_helper'
require 'mock_auth_helper'

feature 'log_in' do
  context 'Visitor already has an account' do
    it 'And they log in w/ FB' do
      user = create :fb_user, fb_id: "10103559484486366"

      stub_oauth

      visit '/'

      within '.welcome' do
        click_on 'Login'
      end

      expect(current_path).to eq("/#{user.username}/home")
      expect(page).to have_content user.username
      expect(page).to have_link "Logout"
      expect(page).to_not have_link "Login"
    end

    it 'And they log in without FB' do
      user = create :user

      visit login_path

      fill_in 'username', with: user.username
    end
  end
end
