require 'rails_helper'

RSpec.describe 'products/index', type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        service: nil,
        name: 'Name',
        origin: 'Origin',
        description: 'MyText',
        is_active: false),
      Product.create!(
        service: nil,
        name: 'Name',
        origin: 'Origin',
        description: 'MyText',
        is_active: false
      )
    ])
  end

  it 'renders a list of products' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Origin'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
