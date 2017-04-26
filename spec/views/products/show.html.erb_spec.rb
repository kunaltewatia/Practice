require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :service => nil,
      :name => "Name",
      :origin => "Origin",
      :description => "MyText",
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Origin/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
