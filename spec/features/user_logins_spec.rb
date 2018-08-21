require 'rails_helper'

RSpec.feature "Visitor logs in", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@doe.com',
      password: '123456',
      password_confirmation: '123456'
    )

    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They are logged in" do
    # ACT
    visit root_path
    find('div#navbar').find_link('Login').click
    within('form') {
      fill_in id: 'email', with: @user.email
      fill_in id: 'password', with: '123456'
      click_button 'Submit'
    }

    sleep 5
    # DEBUG
    save_screenshot 'login_page.png'

    # VERIFY
    expect(page).to have_text 'Signed in as John', count: 1
  end
end