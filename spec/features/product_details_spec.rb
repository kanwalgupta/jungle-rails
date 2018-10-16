require 'rails_helper'
 RSpec.feature "Visitor navigates from home page to product page by clicking on a product", type: :feature, js: true do
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
   scenario "They click on a product and are taken to the product page" do
    # ACT
    visit root_path
     # CLICK
    first('.btn-default').click
     # VERIFY
    expect(page).to have_css '.products-show'
     # DEBUG
    save_screenshot
  end
end