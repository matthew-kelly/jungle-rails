require 'rails_helper'

RSpec.feature "Visitor adds a product to the cart", type: :feature, js: true do

  # SETUP
  before :each do
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

  scenario "They see all products" do
    # ACT
    visit root_path
    first('article.product').find_link('Add').click
    find('div#navbar').find_link('My Cart').click

    sleep 5

    # DEBUG
    save_screenshot 'cart_page.png'

    # VERIFY
    expect(page).to have_text 'My Cart (1)', count: 1
  end
end